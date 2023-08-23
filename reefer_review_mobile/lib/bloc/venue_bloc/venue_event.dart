part of 'venue_bloc.dart';

@immutable
abstract class VenueEvent {}

class FetchVenues extends VenueEvent {}

class SortVenues extends VenueEvent {
  final VenuesSortEnum sortOption;
  final bool isAscending;
  SortVenues({required this.sortOption, required this.isAscending});
}

class FetchAssociatedBrands extends VenueEvent {
  final String venueId;
  FetchAssociatedBrands(this.venueId);
}
