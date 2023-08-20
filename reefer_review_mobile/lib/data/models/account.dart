import 'package:reefer_review_mobile/data/models/product_experience.dart';
import 'package:reefer_review_mobile/data/models/product_preference.dart';

class Account {
  String? displayName;
  String? photoUrl;
  List<ProductPreference> productPreferences;
  List<ProductExperience> productExperiences;

  Account({
    this.displayName,
    this.photoUrl,
    required this.productPreferences,
    required this.productExperiences,
  });
}
