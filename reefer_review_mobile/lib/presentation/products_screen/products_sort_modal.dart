import 'package:flutter/material.dart';
import '../products_screen/products_category_enum.dart';
import '../products_screen/products_sort_enum.dart';

import '../../bloc/product_bloc/product_bloc.dart';

Future<void> showProductsSortModal(
    BuildContext context,
    GlobalKey sortButtonKey,
    ProductBloc productBloc,
    void Function(ProductsSortEnum?, bool) onSortSelected,
    {ProductsSortEnum? initialSortOption,
    bool initialIsAscending = true,
    ProductsCategoryEnum? selectedCategory}) {
  final RenderBox renderBox =
      sortButtonKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);

  var colorScheme = Theme.of(context).colorScheme;

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
          right: MediaQuery.of(context).size.width -
              position.dx -
              renderBox.size.width,
          child: SortOptions(
            colorScheme: colorScheme,
            productBloc: productBloc,
            onSortSelected: onSortSelected,
            initialSortOption: initialSortOption,
            initialIsAscending: initialIsAscending,
            selectedCategory: selectedCategory,
          ),
        )
      ]);
    },
  );
}

class SortOptions extends StatefulWidget {
  final ColorScheme colorScheme;
  final ProductBloc productBloc;
  final Function(ProductsSortEnum?, bool) onSortSelected;
  final ProductsSortEnum? initialSortOption;
  final bool initialIsAscending;
  final ProductsCategoryEnum? selectedCategory;
  const SortOptions({
    super.key,
    required this.colorScheme,
    required this.productBloc,
    required this.onSortSelected,
    required this.initialSortOption,
    required this.initialIsAscending,
    required this.selectedCategory,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SortOptionsState createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  ProductsSortEnum? selectedSortOption;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    selectedSortOption = widget.initialSortOption ?? ProductsSortEnum.Product;
    isAscending = widget.initialIsAscending;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      color: widget.colorScheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20.0),
              child: Text('Sort',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0),
              child: SingleChildScrollView(
                child: ListBody(
                  children: ProductsSortEnum.values
                      .map((e) => sortTile(context, e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sortTile(BuildContext context, ProductsSortEnum sortOption) {
    bool isSelected = sortOption == selectedSortOption;

    bool isDefault = sortOption == ProductsSortEnum.Product &&
        selectedSortOption == ProductsSortEnum.Product &&
        isAscending;

    String sortOptionString = sortOption.toString().split('.').last;

    return InkWell(
      onTap: () {
        setState(() {
          if (selectedSortOption == sortOption) {
            isAscending = !isAscending;
          } else {
            selectedSortOption = sortOption;
            if (sortOption == ProductsSortEnum.Product) {
              isAscending = true;
            }
          }
        });
        widget.productBloc.add(SortProducts(
            sortOption: sortOption,
            isAscending: isAscending,
            category: widget.selectedCategory));
        widget.onSortSelected(selectedSortOption, isAscending);
      },
      child: Container(
        color: isSelected ? Colors.green[100] : null,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sortOptionString,
              style: TextStyle(
                color: isSelected || isDefault ? Colors.green : Colors.black,
                fontWeight: isSelected || isDefault
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            Icon(
              isSelected
                  ? (isAscending
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down)
                  : Icons.keyboard_arrow_up,
              color: isSelected || isDefault ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
