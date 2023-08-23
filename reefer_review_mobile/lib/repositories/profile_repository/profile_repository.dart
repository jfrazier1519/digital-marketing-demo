import 'package:reefer_review_mobile/data/models/profile/profile.dart';
import 'package:reefer_review_mobile/data/models/requests/get_profile_by_id_request.dart';

abstract class ProfileRepository {
  Profile? get currentProfile;

  Future<void> fetchProfileByTypeAndId(GetProfileByIdRequest request);
}
