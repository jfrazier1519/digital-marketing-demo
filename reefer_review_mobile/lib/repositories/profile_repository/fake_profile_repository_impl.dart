import 'package:reefer_review_mobile/data/models/profile/profile.dart';
import 'package:reefer_review_mobile/data/models/requests/get_profile_by_id_request.dart';
import 'package:reefer_review_mobile/repositories/brand_repository/fake_brand_repository_impl.dart';
import 'package:reefer_review_mobile/repositories/profile_repository/profile_repository.dart';

import '../user_repository/fake_user_repository_impl.dart';
import '../venue_repository/fake_venue_repository_impl.dart';

class FakeProfileRepositoryImpl implements ProfileRepository {
  Profile? _currentProfile;

  static final repository = FakeProfileRepositoryImpl();

  @override
  Profile? get currentProfile => _currentProfile;

  @override
  Future<void> fetchProfileByTypeAndId(GetProfileByIdRequest request) async {
    switch (request.type) {
      case ProfileType.BrandProfile:
        _currentProfile = await fetchBrandProfile(request.id);
      case ProfileType.UserProfile:
        _currentProfile = await fetchUserProfile(request.id);
      case ProfileType.VenueProfile:
        _currentProfile = await fetchVenueProfile(request.id);
      default:
    }
  }

  Future<Profile> fetchBrandProfile(String id) async {
    return FakeBrandRepository.repository.getBrandById(id);
  }

  Future<Profile> fetchUserProfile(String id) async {
    return FakeUserRepository.repository.getUserById(id);
  }

  Future<Profile> fetchVenueProfile(String id) async {
    return FakeVenueRepository.repository.getVenueById(id);
  }
}
