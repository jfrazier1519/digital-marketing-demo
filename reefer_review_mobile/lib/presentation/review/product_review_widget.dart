import 'package:flutter/material.dart';

import '../../data/models/review/review.dart';
import '../../data/models/review/product_review.dart'; // You might need to import this if it isn't already.

class ProductReviewWidget extends StatelessWidget {
  final Review review;

  ProductReviewWidget({required this.review});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.1),
            offset: Offset(0, 2),
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
              if (review is ProductReview) ...[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          (review as ProductReview).reviewer.profileImageUrl),
                      radius: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      (review as ProductReview).reviewer.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
              Row(
                children: [
                  Text(
                    review.rating.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.star_border, color: colorScheme.primary, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            review.content,
            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
          ),
          const SizedBox(height: 8.0),
          Text(
            review.date
                .toLocal()
                .toString(), // Formatting the date is up to you
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
