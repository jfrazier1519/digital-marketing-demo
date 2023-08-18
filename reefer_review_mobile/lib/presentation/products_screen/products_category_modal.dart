import 'package:flutter/material.dart';
import 'category_options_enum.dart';
import '../../bloc/product_bloc/product_bloc.dart';

Future<void> showProductsCategoriesModal(
    BuildContext context,
    GlobalKey categoryButtonKey,
    ProductBloc productBloc,
    CategoryOptionsEnum? selectedCategory,
    Function(CategoryOptionsEnum?) onSelectCategory) {
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
            child: CategoriesContent(
                productBloc: productBloc,
                selectedCategory: selectedCategory,
                onSelectCategory: onSelectCategory),
          ),
        )
      ]);
    },
  );
}

class CategoriesContent extends StatefulWidget {
  final ProductBloc productBloc;
  final CategoryOptionsEnum? selectedCategory;
  final Function(CategoryOptionsEnum?) onSelectCategory;


  const CategoriesContent(
      {super.key,
      required this.productBloc,
      this.selectedCategory,
      required this.onSelectCategory});

  // ignore: library_private_types_in_public_api
  _CategoriesContentState createState() => _CategoriesContentState();
}

class _CategoriesContentState extends State<CategoriesContent> {
  CategoryOptionsEnum? selectedCategory;

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
                children: CategoryOptionsEnum.values
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
      BuildContext context, CategoryOptionsEnum? categoryOption) {
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
          widget.productBloc.add(FetchProducts());
        } else {
          widget.productBloc.add(FilterByCategory(selectedCategory!));
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
