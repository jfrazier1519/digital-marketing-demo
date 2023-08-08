import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/post/post.dart';
import 'package:expandable_text/expandable_text.dart'; // Import the expandable_text package
import '../../presentation/shared/rounded_container.dart';
import '../user.dart';

class LoyaltyPost extends Post {
  final String crystals;

  LoyaltyPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
    required this.crystals,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );

  @override
  Widget displayContent(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns the avatar to the top
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(author.profileImageUrl),
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ExpandableText(
                        content,
                        expandText: 'See More',
                        collapseText: 'See Less',
                        maxLines: 2,
                        linkColor: colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.diamond,
                            color: colorScheme.primary,
                          ),
                          Text(
                            ' $crystals crystals',
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
          image.isNotEmpty
              ? Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
