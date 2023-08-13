part of 'venue_bloc.dart';

@immutable
abstract class VenueEvent {}

class FetchVenues extends VenueEvent {}

class SortVenues extends VenueEvent {
  final SortOptionsEnum sortOption;
  final bool isAscending;

  SortVenues({required this.sortOption, required this.isAscending});
}
