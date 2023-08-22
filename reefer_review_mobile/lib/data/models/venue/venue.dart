class Venue {
  final String venueId;
  final String name;
  final String address;
  final String type;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final List<String> brandIds;
  final List<String> productIds;

  Venue({
    required this.venueId,
    required this.name,
    required this.address,
    required this.type,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
    required this.brandIds,
    required this.productIds,
  });
}
