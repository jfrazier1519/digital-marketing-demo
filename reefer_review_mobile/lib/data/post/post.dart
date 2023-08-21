import 'package:reefer_review_mobile/data/models/profile.dart';

abstract class Post {
  final int postId;
  final Profile author;
  final DateTime date;
  final String content;
  final String image;

  Post({
    required this.postId,
    required this.author,
    required this.date,
    required this.content,
    required this.image,
  });
}
