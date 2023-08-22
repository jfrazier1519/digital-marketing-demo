import '../../../presentation/products_screen/products_category_enum.dart';
import 'package:reefer_review_mobile/data/models/profile/profile.dart';

class Brand extends Profile {
  final double rating;
  final int reviewCount;
  final String description;
  final List<ProductsCategoryEnum> categories;
  final List<String> venueIds;

  Brand({
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.categories,
    required this.venueIds,
    required String name,
    required String image,
    required String uid,
  }) : super(
          profileName: name,
          profileImage: image,
          type: ProfileType.BrandProfile,
          uid: uid,
        );
}
