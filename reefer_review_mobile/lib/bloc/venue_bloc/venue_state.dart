part of 'venue_bloc.dart';

@immutable
abstract class VenueState {}

class VenueInitial extends VenueState {}

class VenueLoading extends VenueState {}

class VenuesLoaded extends VenueState {
  final List<Venue> venues;
  VenuesLoaded(this.venues);
}

class AssociatedBrandsLoaded extends VenueState {
  final Venue venue;
  final List<Brand> associatedBrands;
  AssociatedBrandsLoaded(this.venue, this.associatedBrands);
}
