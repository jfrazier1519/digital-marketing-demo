import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/post/post.dart';
import '../../presentation/shared/rounded_container.dart';
import '../user.dart';

class GeneralPost extends Post {
  GeneralPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );

  @override
  Widget displayContent(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(author.profileImageUrl),
                  radius: 25, // Updated radius
                ),
                const SizedBox(width: 20), // Updated space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(content),
                    ],
                  ),
                ),
              ],
            ),
          ),
          image.isNotEmpty
              ? Container(
                  height: 200, // Set the height
                  width: double.infinity, // Stretch across the width
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover, // Fit the image
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
