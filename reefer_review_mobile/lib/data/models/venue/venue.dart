import 'package:reefer_review_mobile/data/models/profile/profile.dart';

class Venue extends Profile {
  final String address;
  final String venueType;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> brandIds;
  final List<String> productIds;

  Venue({
    required this.address,
    required this.venueType,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.brandIds,
    required this.productIds,
    required String name,
    required String image,
    required String uid,
  }) : super(
          profileName: name,
          profileImage: image,
          type: ProfileType.VenueProfile,
          uid: uid,
        );
}
