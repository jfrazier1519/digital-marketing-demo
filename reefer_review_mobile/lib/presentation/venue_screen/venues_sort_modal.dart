import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './venues_sort_enum.dart';
import '../../bloc/venue_bloc/venue_bloc.dart';

Future<void> showVenueSortModal(
  BuildContext context,
  GlobalKey sortButtonKey,
  VenueBloc venueBloc,
  void Function(VenuesSortEnum?, bool) onSortSelected, {
  VenuesSortEnum? initialSortOption,
  bool initialIsAscending = true,
}) {
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
      return Stack(
        children: [
          Positioned(
            top: position.dy +
                renderBox.size.height, // Just below the icon in AppBar
            right: MediaQuery.of(context).size.width -
                position.dx -
                renderBox.size
                    .width, // Align to the right of the screen based on the icon position
            child: VenueSortOptions(
              colorScheme: colorScheme,
              venueBloc: venueBloc,
              onSortSelected: onSortSelected,
              initialSortOption: initialSortOption,
              initialIsAscending: initialIsAscending,
            ),
          )
        ],
      );
    },
  );
}

class VenueSortOptions extends StatefulWidget {
  final ColorScheme colorScheme;
  final VenueBloc venueBloc;
  final Function(VenuesSortEnum?, bool) onSortSelected;
  final VenuesSortEnum? initialSortOption;
  final bool initialIsAscending;

  VenueSortOptions({
    required this.colorScheme,
    required this.venueBloc,
    required this.onSortSelected,
    required this.initialSortOption,
    required this.initialIsAscending,
  });

  @override
  _VenueSortOptionsState createState() => _VenueSortOptionsState();
}

class _VenueSortOptionsState extends State<VenueSortOptions> {
  VenuesSortEnum? selectedSortOption;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    selectedSortOption = widget.initialSortOption ?? VenuesSortEnum.Venue;
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
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20.0),
              child: Text('Sort',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0),
              child: SingleChildScrollView(
                child: ListBody(
                  children: VenuesSortEnum.values
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

  Widget sortTile(BuildContext context, VenuesSortEnum sortOption) {
    bool isSelected = sortOption == selectedSortOption;

    String sortOptionString = sortOption.toString().split('.').last;

    bool isHighlightedGreen =
        (sortOption == VenuesSortEnum.Venue && isAscending && isSelected) ||
            isSelected;

    return InkWell(
      onTap: () {
        setState(() {
          if (selectedSortOption == sortOption) {
            isAscending = !isAscending;
          } else {
            selectedSortOption = sortOption;
            if (sortOption == VenuesSortEnum.Venue) {
              isAscending = true;
            }
          }
        });
        widget.venueBloc
            .add(SortVenues(sortOption: sortOption, isAscending: isAscending));
        widget.onSortSelected(selectedSortOption, isAscending);
      },
      child: Container(
        color: isHighlightedGreen ? Colors.green[100] : null,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
