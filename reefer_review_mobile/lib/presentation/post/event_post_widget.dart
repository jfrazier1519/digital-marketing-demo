import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/event_post.dart';

class EventPostWidget extends StatelessWidget {
  final EventPost eventPost;

  const EventPostWidget({super.key, required this.eventPost});

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
                      AssetImage(eventPost.author.profileImageUrl ?? ''),
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventPost.author.profileName ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ExpandableText(
                        eventPost.content,
                        expandText: 'See More',
                        collapseText: 'See Less',
                        maxLines: 2,
                        linkColor: colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(eventPost.eventUrl);
                        },
                        child: Text(
                          'Go To Event',
                          style: TextStyle(
                            color: colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          eventPost.image.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    eventPost.image,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
