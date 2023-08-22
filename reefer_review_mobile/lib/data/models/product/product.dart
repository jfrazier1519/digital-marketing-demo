import 'package:reefer_review_mobile/data/models/product/product_price.dart';

class Product {
  final String productId;
  final String name;
  final String category;
  final String brand;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final List<Price> prices;

  Product({
    required this.productId,
    required this.name,
    required this.category,
    required this.brand,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
    required this.prices,
  });
}
