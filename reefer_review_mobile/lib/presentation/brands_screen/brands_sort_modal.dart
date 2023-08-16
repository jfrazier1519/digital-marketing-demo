import 'package:flutter/material.dart';
import '../../bloc/brand_bloc/brand_bloc.dart';
import './brands_sort_enum.dart';
import './brands_category_enum.dart';

Future<void> showBrandSortModal(BuildContext context, GlobalKey sortButtonKey,
    BrandBloc brandBloc, void Function(BrandsSortEnum?, bool) onSortSelected,
    {BrandsSortEnum? initialSortOption,
    bool initialIsAscending = true,
    BrandsCategoryEnum? selectedCategory}) {
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
          child: BrandSortOptions(
            colorScheme: colorScheme,
            brandBloc: brandBloc,
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

class BrandSortOptions extends StatefulWidget {
  final ColorScheme colorScheme;
  final BrandBloc brandBloc;
  final Function(BrandsSortEnum?, bool) onSortSelected;
  final BrandsSortEnum? initialSortOption;
  final bool initialIsAscending;
  final BrandsCategoryEnum? selectedCategory;

  const BrandSortOptions({
    super.key,
    required this.colorScheme,
    required this.brandBloc,
    required this.onSortSelected,
    required this.initialSortOption,
    required this.initialIsAscending,
    required this.selectedCategory,
  });

  @override
  _BrandSortOptionsState createState() => _BrandSortOptionsState();
}

class _BrandSortOptionsState extends State<BrandSortOptions> {
  BrandsSortEnum? selectedSortOption;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    selectedSortOption = widget.initialSortOption ?? BrandsSortEnum.Brand;
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
                  children: BrandsSortEnum.values
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

  Widget sortTile(BuildContext context, BrandsSortEnum sortOption) {
    bool isSelected = sortOption == selectedSortOption;

    String sortOptionString = sortOption.toString().split('.').last;

    bool isHighlightedGreen =
        (sortOption == BrandsSortEnum.Brand && isAscending && isSelected) ||
            isSelected;

    return InkWell(
      onTap: () {
        setState(() {
          if (selectedSortOption == sortOption) {
            isAscending = !isAscending;
          } else {
            selectedSortOption = sortOption;
            if (sortOption == BrandsSortEnum.Brand) {
              isAscending = true;
            }
          }
        });
        widget.brandBloc.add(SortBrands(
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
                color: isHighlightedGreen ? Colors.green : Colors.black,
                fontWeight:
                    isHighlightedGreen ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Icon(
              isSelected
                  ? (isAscending
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down)
                  : Icons.keyboard_arrow_up,
              color: isHighlightedGreen ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
