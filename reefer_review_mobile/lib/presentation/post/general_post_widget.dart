import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/general_post.dart';

class GeneralPostWidget extends StatelessWidget {
  final GeneralPost generalPost;

  GeneralPostWidget({required this.generalPost});

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
                      AssetImage(generalPost.author.profileImageUrl),
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        generalPost.author.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ExpandableText(
                        generalPost.content,
                        expandText: 'See More',
                        collapseText: 'See Less',
                        maxLines: 2,
                        linkColor: colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          generalPost.image.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    generalPost.image,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
