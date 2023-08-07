import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/post/post.dart';
import '../../presentation/shared/rounded_container.dart';
import '../user.dart';

class ReviewPost extends Post {
  final double reviewStars;

  ReviewPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
    required this.reviewStars,
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
                      Text(content),
                      const SizedBox(height: 10),
                      Row(
                        children: List.generate(
                          reviewStars.toInt(),
                          (index) => Icon(Icons.star, color: Colors.green),
                        ),
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
