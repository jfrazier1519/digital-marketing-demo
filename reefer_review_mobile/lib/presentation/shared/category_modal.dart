import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc/product_bloc.dart';

Future<void> showCategoriesModal(
    BuildContext context,
    GlobalKey categoryButtonKey,
    ProductBloc productBloc,
    String? selectedCategory,
    Function(String?) onSelectCategory) {
  // <-- Added selectedCategory and onSelectCategory
  var colorScheme = Theme.of(context).colorScheme;

  final RenderBox renderBox =
      categoryButtonKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(
      Offset.zero); // this will give you the position of the context widget

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
          top: position.dy + renderBox.size.height, // position below the button
          left: MediaQuery.of(context).size.width * 0.25, // centering the modal
          child: Material(
            elevation: 4.0,
            color: colorScheme.background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: CategoriesContent(
                productBloc: productBloc,
                selectedCategory: selectedCategory,
                onSelectCategory:
                    onSelectCategory), // <-- Pass selectedCategory and onSelectCategory
          ),
        )
      ]);
    },
  );
}

class CategoriesContent extends StatefulWidget {
  final ProductBloc productBloc;
  final String? selectedCategory; // <-- Add this
  final Function(String?) onSelectCategory; // <-- Add this callback

  CategoriesContent(
      {required this.productBloc,
      this.selectedCategory,
      required this.onSelectCategory}); // <-- Update constructor

  @override
  _CategoriesContentState createState() => _CategoriesContentState();
}

class _CategoriesContentState extends State<CategoriesContent> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget
        .selectedCategory; // <-- Initialize with the passed selectedCategory
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10.0),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  categoryTile(context, 'Flower'),
                  categoryTile(context, 'Accessories'),
                  categoryTile(context, 'Concentrates'),
                  categoryTile(context, 'Oils'),
                  categoryTile(context, 'Merch'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryTile(BuildContext context, String category) {
    bool isSelected = category == selectedCategory;

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            // Deselect the category if it was previously selected
            selectedCategory = null;
            widget.productBloc.add(FetchProducts()); // Fetch all products
          } else {
            // Select the category
            selectedCategory = category;
            widget.productBloc.add(FilterByCategory(category));
          }
        });
        widget.onSelectCategory(selectedCategory);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.green : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
