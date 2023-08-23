import 'package:reefer_review_mobile/data/models/profile/profile.dart';
import 'package:reefer_review_mobile/data/models/requests/get_profile_by_id_request.dart';
import 'package:reefer_review_mobile/repositories/brand_repository/fake_brand_repository_impl.dart';
import 'package:reefer_review_mobile/repositories/profile_repository/profile_repository.dart';

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
      default:
    }
  }

  Future<Profile> fetchBrandProfile(String id) async {
    return FakeBrandRepository.repository.getBrandById(id);
  }
}
