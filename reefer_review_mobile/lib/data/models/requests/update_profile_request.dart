import 'package:reefer_review_mobile/data/models/product/product_experience.dart';
import 'package:reefer_review_mobile/data/models/product/product_preference.dart';

class UpdateProfileRequest {
  final String? displayName;
  final String? photoUrl;
  final ProductPreference? preference;
  final ProductExperience? experience;
  UpdateProfileRequest({
    this.displayName,
    this.photoUrl,
    this.preference,
    this.experience,
  });
}
