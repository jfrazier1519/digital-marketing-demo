import '../../data/models/venue/venue.dart';

abstract class VenueRepository {
  Future<List<Venue>> getAllVenues();
  Future<List<Venue>> getVenuesByAddress(String address);
  Future<List<Venue>> sortVenues(
      String sortOption, bool isAscending, List<Venue> venues);
  Future<Venue> getVenueById(String uid);
  Future<void> addVenue(Venue venue);
  Future<void> updateVenue(Venue venue);
  Future<void> deleteVenue(String venueId);
}
