import '../../../presentation/products_screen/products_category_enum.dart';

class Brand {
  final String brandId;
  final String name;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final List<ProductsCategoryEnum> categories;
  final List<String> venueIds;

  Brand(
      {required this.brandId,
      required this.name,
      required this.rating,
      required this.reviewCount,
      required this.description,
      required this.image,
      required this.categories,
      required this.venueIds});
}
