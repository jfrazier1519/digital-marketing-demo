import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/shared/navigation_menu.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venue_widget.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venues_sort_modal.dart';
import '../../bloc/venue_bloc/venue_bloc.dart';
import '../../repositories/venue_repository/fake_venue_repository_impl.dart';
import 'venues_sort_enum.dart';

class VenuesScreen extends StatelessWidget {
  const VenuesScreen({Key? key}) : super(key: key);

  static const route = '/venues';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VenueBloc(FakeVenueRepository.repository)..add(FetchVenues()),
      child: _VenuesScreenContent(),
    );
  }
}

class _VenuesScreenContent extends StatefulWidget {
  @override
  _VenuesScreenContentState createState() => _VenuesScreenContentState();
}

class _VenuesScreenContentState extends State<_VenuesScreenContent> {
  final int _currentIndex = 2;
  VenuesSortEnum? _selectedSortOption;
  final bool _isAscending = true;
  final bool _isSortModalOpen = false;
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

    return Scaffold(
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
                      itemBuilder: (context, index) => Container(
                            margin:
                                const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            child: VenueWidget(venue: state.venues[index]),
                          ));
                } else {
                  return const Text('Something went wrong!');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
