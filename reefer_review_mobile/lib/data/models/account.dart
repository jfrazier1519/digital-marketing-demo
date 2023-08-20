import 'package:reefer_review_mobile/data/models/product_experience.dart';
import 'package:reefer_review_mobile/data/models/product_preference.dart';
import 'package:reefer_review_mobile/data/models/profile.dart';

class Account extends Profile {
  List<ProductPreference> productPreferences;
  List<ProductExperience> productExperiences;
  String? displayName;
  String? photoUrl;
  String email;

  Account({
    required String uid,
    this.displayName,
    this.photoUrl,
    required this.productPreferences,
    required this.productExperiences,
    required this.email,
  }) : super(
          type: ProfileType.UserProfile,
          profileName: displayName,
          profileImage: photoUrl,
          uid: uid,
        );
}
