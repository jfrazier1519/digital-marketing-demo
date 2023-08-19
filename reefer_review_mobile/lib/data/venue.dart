class Venue {
  final int venueId;
  final String name;
  final String location;
  final String type;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final List<int> brandIds;

  Venue({
    required this.venueId,
    required this.name,
    required this.location,
    required this.type,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
    required this.brandIds,
  });
}
