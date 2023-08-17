import '../../presentation/brands_screen/brands_category_enum.dart';

class Brand {
  final int brandId;
  final String name;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final List<BrandsCategoryEnum> categories;

  Brand({
    required this.brandId,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
    required this.categories,
  });
}
