import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/venue_bloc/venue_bloc.dart';
import '../../repositories/venue_repository/fake_venue_repository_impl.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/sort_modal.dart';
import 'venues_sort_enum.dart'; // Create a separate enum for Venue sort options

class VenuesScreen extends StatelessWidget {
  const VenuesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VenueBloc(FakeVenueRepository())
        ..add(
            FetchVenues()), // Replace FetchProducts() with FetchVenues() in your new bloc
      child: _VenuesScreenContent(),
    );
  }
}

class _VenuesScreenContent extends StatefulWidget {
  @override
  _VenuesScreenContentState createState() => _VenuesScreenContentState();
}

class _VenuesScreenContentState extends State<_VenuesScreenContent> {
  int _currentIndex = 1;
  bool _isSortSelected = false;
  VenuesSortEnum? _selectedSortOption;
  bool _isAscending = true;

  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Venues'),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            //   onPressed: () {
            //     if (_isSortSelected) {
            //       Navigator.pop(context);
            //       setState(() {
            //         _isSortSelected = false;
            //       });
            //     } else {
            //       setState(() {
            //         _isSortSelected = true;
            //       });
            //       showSortModal<VenuesSortEnum>(
            //         context,
            //         _sortButtonKey,
            //         BlocProvider.of<VenueBloc>(context),
            //         (sortOption, isAscendingDirection) {
            //           setState(() {
            //             _selectedSortOption = sortOption;
            //             _isAscending = isAscendingDirection;
            //           });
            //         },
            //         initialSortOption: _selectedSortOption,
            //         initialIsAscending: _isAscending,
            //       ).then((_) {
            //         setState(() {
            //           _isSortSelected = false;
            //         });
            //       });
            //     }
            //   },
            // ),
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
                    return CircularProgressIndicator();
                  } else if (state is VenuesLoaded) {
                    return ListView.builder(
                      itemCount: state.venues.length,
                      itemBuilder: (context, index) => state.venues[index]
                          .displayContent(
                              context), // Make sure the venue object has a method to display its content
                    );
                  } else {
                    return Text('Something went wrong!');
                  }
                },
              ),
            ),
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
