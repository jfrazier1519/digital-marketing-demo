import '../../data/venue.dart';

abstract class VenueRepository {
  Future<List<Venue>> getAllVenues();
  Future<List<Venue>> getVenuesByLocation(String location);
  Future<List<Venue>> sortVenues(
      String sortOption, bool isAscending, List<Venue> venues);
  Future<Venue> getVenueById(int id);
  Future<void> addVenue(Venue venue);
  Future<void> updateVenue(Venue venue);
  Future<void> deleteVenue(int venueId);
}
