import 'package:reefer_review_mobile/repositories/brand_repository/brand_repository.dart';
import 'package:reefer_review_mobile/repositories/user_repository/user_repository.dart';
import 'package:reefer_review_mobile/repositories/venue_repository/venue_repository.dart';
import '../../data/models/profile/profile.dart';

class EntityDispatcher {
  final UserRepository userRepo;
  final BrandRepository brandRepo;
  final VenueRepository venueRepo;

  EntityDispatcher({
    required this.userRepo,
    required this.brandRepo,
    required this.venueRepo,
  });

  Future<Profile?> fetchEntityByProfileIdAndType(
      String id, ProfileType type) async {
    try {
      switch (type) {
        case ProfileType.UserProfile:
          return userRepo.getUserById(id);
        case ProfileType.BrandProfile:
          return brandRepo.getBrandById(id);
        case ProfileType.VenueProfile:
          return venueRepo.getVenueById(id);
        default:
          return null;
      }
    } catch (error) {
      print('Error fetching entity: $error');
      throw Exception('Failed to fetch entity by profile ID and type.');
    }
  }
}
