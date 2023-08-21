import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/review_post.dart';

class ReviewPostWidget extends StatelessWidget {
  final ReviewPost reviewPost;

  const ReviewPostWidget({super.key, required this.reviewPost});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage(reviewPost.author.profileImage ?? ''),
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewPost.author.profileName ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ExpandableText(
                        reviewPost.content,
                        expandText: 'See More',
                        collapseText: 'See Less',
                        maxLines: 2,
                        linkColor: colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.star_border, color: colorScheme.primary),
                          Text(
                            ' ${reviewPost.reviewStars} Stars',
                            style: TextStyle(
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          reviewPost.image.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    reviewPost.image,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
