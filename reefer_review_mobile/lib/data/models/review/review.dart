import '../user.dart';

abstract class Review {
  final int reviewId;
  final User reviewer;
  final String content;
  final DateTime date;
  final int rating;
  final String title;

  Review(
      {required this.reviewId,
      required this.reviewer,
      required this.content,
      required this.date,
      required this.rating,
      required this.title});
}
