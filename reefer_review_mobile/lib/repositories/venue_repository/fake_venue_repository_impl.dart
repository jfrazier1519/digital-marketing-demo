import 'package:reefer_review_mobile/data/venue.dart';
import 'package:reefer_review_mobile/repositories/venue_repository/venue_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

class FakeVenueRepository implements VenueRepository {
  List<Venue> _allVenues = [];

  FakeVenueRepository() {
    _allVenues = [
      Venue(
          venueId: 1,
          name: "Sample Venue 1",
          location: "Location A",
          type: "Distillery",
          rating: 4.5,
          reviewCount: 10,
          description: "Very professional establishment.",
          image: venue1,
          brandIds: [1]),
      Venue(
          venueId: 2,
          name: "Sample Venue 2",
          location: "Location B",
          type: "Bar",
          rating: 3.8,
          reviewCount: 25,
          description:
              "This is a fantastic bar located in Location B. They sell weed in the back",
          image: venue2,
          brandIds: [2]),
    ];
  }

  @override
  Future<List<Venue>> getAllVenues() async {
    return _allVenues;
  }

  @override
  Future<Venue> getVenueById(int id) async {
    return _allVenues.firstWhere((venue) => venue.venueId == id);
  }

  @override
  Future<void> addVenue(Venue venue) async {
    _allVenues.add(venue);
  }

  @override
  Future<void> deleteVenue(int venueId) async {
    _allVenues.removeWhere((venue) => venue.venueId == venueId);
  }

  @override
  Future<void> updateVenue(Venue updatedVenue) async {
    int index =
        _allVenues.indexWhere((venue) => venue.venueId == updatedVenue.venueId);
    if (index != -1) {
      _allVenues[index] = updatedVenue;
    }
  }

  @override
  Future<List<Venue>> getVenuesByLocation(String location) async {
    return _allVenues.where((venue) => venue.location == location).toList();
  }

  @override
  Future<List<Venue>> sortVenues(String sortOption, bool isAscending,
      [List<Venue>? venues]) async {
    List<Venue> venueList = venues ?? _allVenues;

    Comparator<Venue> comparator;

    switch (sortOption) {
      case 'Venue':
        comparator = (a, b) => a.name.compareTo(b.name);
        break;
      case 'Type':
        comparator = (a, b) => a.type.compareTo(b.type);
        break;
      case 'Rating':
        comparator = (a, b) => a.rating.compareTo(b.rating);
        break;
      case 'Reviews':
        comparator = (a, b) => a.reviewCount.compareTo(b.reviewCount);
        break;
      default:
        comparator = (a, b) => a.name.compareTo(b.name);
        break;
    }

    venueList
        .sort((a, b) => isAscending ? comparator(a, b) : -comparator(a, b));

    return venueList;
  }
}
