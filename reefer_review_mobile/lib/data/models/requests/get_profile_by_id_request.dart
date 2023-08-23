import 'package:reefer_review_mobile/data/models/profile/profile.dart';

class GetProfileByIdRequest {
  final String id;
  final ProfileType type;
  GetProfileByIdRequest(this.id, this.type);
}
