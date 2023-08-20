import 'package:reefer_review_mobile/data/models/profile.dart';

abstract class Review {
  final int reviewId;
  final Profile reviewer;
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
