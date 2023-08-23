import 'package:reefer_review_mobile/data/models/product/product_experience.dart';
import 'package:reefer_review_mobile/data/models/product/product_preference.dart';
import 'package:reefer_review_mobile/data/models/profile/profile.dart';

class User extends Profile {
  List<ProductPreference> productPreferences;
  List<ProductExperience> productExperiences;
  String? displayName;
  String? photoUrl;
  String email;
  final List<String> followedBrands;
  final List<String> followedVenues;
  final List<String> followedUsers;

  User({
    required String uid,
    this.displayName,
    this.photoUrl,
    required this.followedBrands,
    required this.followedVenues,
    required this.followedUsers,
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
