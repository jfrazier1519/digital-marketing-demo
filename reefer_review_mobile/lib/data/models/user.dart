class User {
  final String userId;
  final String email;
  final String name;
  final String profileImageUrl;
  final List<int> followedBrands;

  User(
      {required this.userId,
      required this.email,
      required this.name,
      required this.profileImageUrl,
      required this.followedBrands});
}
