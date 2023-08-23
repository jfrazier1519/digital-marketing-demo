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
        name: "Grangers Glass",
        address: "2446 west Northfolk Drive, Huntsville AL, 11463",
        venueType: 'Distributor',
        rating: 4.3,
        reviewCount: 32,
        description:
            "We are Glass Makers and sellers. We make all sortfs of accessories for both smoking and vaporizing cannabis. Some see us at our Northfolk Drive location!",
        image: venueID1,
        brandIds: ['4'],
        productIds: ['11', '12', '13', '14']),
    Venue(
        uid: "2",
        name: "Peace of Pie",
        address: "766 South East Street, Kent WA, 98106",
        venueType: 'Grower, Distributor',
        rating: 4.1,
        reviewCount: 12,
        description:
            "Growers of fine smokables as well as distributors of the best edibvles around.",
        image: venueID2,
        brandIds: ['1', '2', '3'],
        productIds: ['1', '2', '3', '4', '8', '9', '10']),
    Venue(
        uid: "3",
        name: "Big Al's",
        address: "84667 54th Circle, Portland OR, 45824",
        venueType: 'Distributor, Pharmacy',
        rating: 4.7,
        reviewCount: 26,
        description:
            "Medical grade cannabis at a good price. Make an apointment to come see us today!",
        image: venueID3,
        brandIds: ['1', '2', '3'],
        productIds: ['1', '2', '3', '4', '5', '6', '7']),
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
