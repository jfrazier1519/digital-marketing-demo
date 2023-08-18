import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venue_widget.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venues_sort_modal.dart';
import '../../bloc/venue_bloc/venue_bloc.dart';
import '../../repositories/venue_repository/fake_venue_repository_impl.dart';
import '../shared/bottom_nav_bar.dart';
import 'venues_sort_enum.dart';

class VenuesScreen extends StatelessWidget {
  const VenuesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VenueBloc(FakeVenueRepository())..add(FetchVenues()),
      child: _VenuesScreenContent(),
    );
  }
}

class _VenuesScreenContent extends StatefulWidget {
  @override
  _VenuesScreenContentState createState() => _VenuesScreenContentState();
}

class _VenuesScreenContentState extends State<_VenuesScreenContent> {
  int _currentIndex = 2;
  VenuesSortEnum? _selectedSortOption;
  bool _isAscending = true;
  bool _isSortModalOpen = false;
  final GlobalKey sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Color sortIconColor;
    if (_isSortModalOpen) {
      sortIconColor = colorScheme.outlineVariant;
    } else if (_selectedSortOption == null ||
        (_selectedSortOption == VenuesSortEnum.Venue && _isAscending)) {
      sortIconColor = Colors.white;
    } else {
      sortIconColor = colorScheme.outlineVariant;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Venues'),
          actions: [
            IconButton(
              key: sortButtonKey,
              icon: Icon(Icons.filter_alt_outlined, color: sortIconColor),
              onPressed: () {
                setState(() {
                  _isSortModalOpen = true;
                });

                showVenueSortModal(
                  context,
                  sortButtonKey,
                  BlocProvider.of<VenueBloc>(context),
                  (sortOption, isAscendingDirection) {
                    setState(() {
                      _selectedSortOption = sortOption;
                      _isAscending = isAscendingDirection;
                    });
                  },
                  initialSortOption: _selectedSortOption,
                  initialIsAscending: _isAscending,
                ).then((_) {
                  setState(() {
                    _isSortModalOpen = false;
                  });
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<VenueBloc, VenueState>(
                builder: (context, state) {
                  if (state is VenueLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is VenuesLoaded) {
                    return ListView.builder(
                      itemCount: state.venues.length,
                      itemBuilder: (context, index) =>
                          VenueWidget(venue: state.venues[index]),
                    );
                  } else {
                    return const Text('Something went wrong!');
                  }
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
