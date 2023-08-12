import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc/product_bloc.dart';

Future<void> showSortModal(
    BuildContext context, GlobalKey sortButtonKey, ProductBloc productBloc) {
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
          child:
              SortOptions(colorScheme: colorScheme, productBloc: productBloc),
        )
      ]);
    },
  );
}

class SortOptions extends StatefulWidget {
  final ColorScheme colorScheme;
  final ProductBloc productBloc;

  SortOptions({required this.colorScheme, required this.productBloc});

  @override
  _SortOptionsState createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  String? selectedSortOption;
  bool isAscending = true;

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
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20.0),
              child: Text('Sort',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0),
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    sortTile(context, 'Product', Icons.keyboard_arrow_up),
                    sortTile(context, 'Brand', Icons.keyboard_arrow_up),
                    sortTile(context, 'Rating', Icons.keyboard_arrow_up),
                    sortTile(context, 'Reviews', Icons.keyboard_arrow_up),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sortTile(BuildContext context, String sortOption, IconData icon) {
    bool isSelected = sortOption == selectedSortOption;

    return InkWell(
      onTap: () {
        setState(() {
          if (selectedSortOption == sortOption) {
            isAscending = !isAscending;
          } else {
            selectedSortOption = sortOption;
            isAscending = true;
          }
        });
        widget.productBloc.add(SortProducts(
            sortOption: sortOption.toLowerCase(), isAscending: isAscending));
      },
      child: Container(
        color: isSelected ? Colors.green[100] : null,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sortOption,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Icon(
              isSelected
                  ? (isAscending
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down)
                  : Icons.keyboard_arrow_up,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
