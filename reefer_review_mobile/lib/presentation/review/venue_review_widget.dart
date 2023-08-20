import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/review/review.dart';
import '../../data/models/review/venue_review.dart';

class VenueReviewWidget extends StatelessWidget {
  final Review review;

  const VenueReviewWidget({super.key, required this.review});

  List<Widget> buildStars(int rating, ColorScheme colorScheme) {
    List<Widget> stars = [];
    for (var i = 1; i <= 5; i++) {
      stars.add(Icon(
        i <= rating ? Icons.star_border : Icons.star_border,
        color: i <= rating ? colorScheme.primary : colorScheme.outlineVariant,
        size: 20,
      ));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (review is VenueReview) ...[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          (review as VenueReview).reviewer.profileImageUrl ??
                              ''),
                      radius: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      (review as VenueReview).reviewer.name ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  "${DateFormat('h:mma').format(review.date)} - ${DateFormat('M/d/yy').format(review.date)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8.0),
          Row(children: [
            ...buildStars(review.rating, colorScheme),
            const SizedBox(width: 10.0),
            Text(review.title,
                style: const TextStyle(fontWeight: FontWeight.bold))
          ]),
          const SizedBox(height: 8.0),
          Text(
            review.content,
            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}
