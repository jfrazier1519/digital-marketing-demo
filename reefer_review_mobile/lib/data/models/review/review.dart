abstract class Review {
  final String reviewId;
  final String reviewerId;
  final String content;
  final DateTime date;
  final int rating;
  final String title;

  Review(
      {required this.reviewId,
      required this.reviewerId,
      required this.content,
      required this.date,
      required this.rating,
      required this.title});
}
