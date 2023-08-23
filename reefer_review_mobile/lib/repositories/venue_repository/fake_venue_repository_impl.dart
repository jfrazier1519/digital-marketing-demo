import 'package:reefer_review_mobile/data/models/venue/venue.dart';
import 'package:reefer_review_mobile/repositories/venue_repository/venue_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../utilities/custom_entity_exception.dart';

class FakeVenueRepository implements VenueRepository {
  static VenueRepository repository = FakeVenueRepository._internal();

  FakeVenueRepository._internal();

  final List<Venue> _allVenues = [
    Venue(
        uid: "1",
        name: "Sample Venue 1",
        address: "1245 Strawberry Ln, Luxerburg CO, 88897",
        venueType: 'Distillery',
        rating: 4.5,
        reviewCount: 10,
        description: "Very professional establishment.",
        image: venue1,
        brandIds: ['1'],
        productIds: ['1', '2', '3']),
    Venue(
        uid: "2",
        name: "Sample Venue 2",
        address: "Location B",
        venueType: 'Bar',
        rating: 3.8,
        reviewCount: 25,
        description:
            "This is a fantastic bar located in Location B. They sell weed in the back",
        image: venue2,
        brandIds: ['2'],
        productIds: ['4', '5']),
  ];

  @override
  Future<List<Venue>> getAllVenues() async {
    return _allVenues;
  }

  @override
  Future<Venue> getVenueById(String uid) async {
    try {
      return _allVenues.firstWhere((venue) => venue.uid == uid);
    } catch (_) {
      throw EntityNotFoundException('Venue with id $uid not found');
    }
  }

  @override
  Future<void> addVenue(Venue venue) async {
    _allVenues.add(venue);
  }

  @override
  Future<void> deleteVenue(String venueId) async {
    _allVenues.removeWhere((venue) => venue.uid == venueId);
  }

  @override
  Future<void> updateVenue(Venue updatedVenue) async {
    int index = _allVenues.indexWhere((venue) => venue.uid == updatedVenue.uid);
    if (index != -1) {
      _allVenues[index] = updatedVenue;
    }
  }

  @override
  Future<List<Venue>> getVenuesByAddress(String address) async {
    return _allVenues.where((venue) => venue.address == address).toList();
  }

  @override
  Future<List<Venue>> sortVenues(String sortOption, bool isAscending,
      [List<Venue>? venues]) async {
    List<Venue> venueList = venues ?? _allVenues;

    Comparator<Venue> comparator;

    switch (sortOption) {
      case 'Venue':
        comparator = (a, b) => a.profileName!.compareTo(b.profileName!);
        break;
      case 'Type':
        comparator = (a, b) => a.venueType.compareTo(b.venueType);
        break;
      case 'Rating':
        comparator = (a, b) => a.rating.compareTo(b.rating);
        break;
      case 'Reviews':
        comparator = (a, b) => a.reviewCount.compareTo(b.reviewCount);
        break;
      default:
        comparator = (a, b) => a.profileName!.compareTo(b.profileName!);
        break;
    }

    venueList
        .sort((a, b) => isAscending ? comparator(a, b) : -comparator(a, b));

    return venueList;
  }
}
