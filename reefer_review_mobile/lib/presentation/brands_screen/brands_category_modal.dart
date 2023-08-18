import 'package:flutter/material.dart';
import '../../bloc/brand_bloc/brand_bloc.dart';
import '../products_screen/products_category_enum.dart';

Future<void> showBrandCategoriesModal(
    BuildContext context,
    GlobalKey categoryButtonKey,
    BrandBloc brandBloc,
    ProductsCategoryEnum? selectedCategory,
    Function(ProductsCategoryEnum?) onSelectCategory) {
  var colorScheme = Theme.of(context).colorScheme;

  final RenderBox renderBox =
      categoryButtonKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);

  return showGeneralDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Stack(children: [
        Positioned(
          top: position.dy + renderBox.size.height,
          left: MediaQuery.of(context).size.width * 0.25,
          child: Material(
            elevation: 4.0,
            color: colorScheme.background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: BrandsCategoriesContent(
                brandBloc: brandBloc,
                selectedCategory: selectedCategory,
                onSelectCategory: onSelectCategory),
          ),
        )
      ]);
    },
  );
}

class BrandsCategoriesContent extends StatefulWidget {
  final BrandBloc brandBloc;
  final ProductsCategoryEnum? selectedCategory;
  final Function(ProductsCategoryEnum?) onSelectCategory;

  const BrandsCategoriesContent(
      {super.key,
      required this.brandBloc,
      this.selectedCategory,
      required this.onSelectCategory});

  @override
  // ignore: library_private_types_in_public_api
  _BrandsCategoriesContentState createState() =>
      _BrandsCategoriesContentState();
}

class _BrandsCategoriesContentState extends State<BrandsCategoriesContent> {
  ProductsCategoryEnum? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10.0),
            child: SingleChildScrollView(
              child: ListBody(
                children: ProductsCategoryEnum.values
                    .map((e) => categoryTile(context, e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryTile(
      BuildContext context, ProductsCategoryEnum? categoryOption) {
    bool isSelected = selectedCategory == categoryOption;
    String categoryOptionString = categoryOption != null
        ? categoryOption.toString().split('.').last
        : "Unknown";

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCategory = null;
          } else {
            selectedCategory = categoryOption;
          }
        });

        if (selectedCategory == null) {
          widget.brandBloc.add(FetchBrands());
        } else {
          widget.brandBloc.add(FilterByCategory(selectedCategory!));
        }
        widget.onSelectCategory(selectedCategory);
      },
      child: Container(
        color: isSelected ? Colors.green[100] : null,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          categoryOptionString,
          style: TextStyle(
            color: isSelected ? Colors.green : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
