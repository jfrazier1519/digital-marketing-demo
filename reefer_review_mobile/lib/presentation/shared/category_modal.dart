import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc/product_bloc.dart';

Future<void> showCategoriesModal(BuildContext context,
    GlobalKey categoryButtonKey, ProductBloc productBloc) {
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
            elevation: 4.0, // Adjust this value to change the shadow size
            color: colorScheme.background, // Set the background color here
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.5, // 50% of screen width, same as the sort modal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text('Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20)), // Increase the font size here
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10.0),
                    child: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          categoryTile(context, 'Flower', productBloc),
                          categoryTile(context, 'Accessories', productBloc),
                          categoryTile(context, 'Concentrates', productBloc),
                          categoryTile(context, 'Oils', productBloc),
                          categoryTile(context, 'Merch', productBloc),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]);
    },
  );
}

Widget categoryTile(
    BuildContext context, String category, ProductBloc productBloc) {
  return InkWell(
    onTap: () {
      // Filtering by category
      productBloc.add(FilterByCategory(category));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(category),
    ),
  );
}
