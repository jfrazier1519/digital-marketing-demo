import '../models/profile/profile.dart';

abstract class Post {
  final String postId;
  final String authorId;
  final ProfileType profileType;
  final DateTime date;
  final String content;
  final String image;

  Post(
    this.profileType, {
    required this.postId,
    required this.authorId,
    required this.date,
    required this.content,
    required this.image,
  });
}
