import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/product_post.dart';

class ProductPostWidget extends StatelessWidget {
  final ProductPost productPost;

  ProductPostWidget({required this.productPost});

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
                      AssetImage(productPost.author.profileImageUrl),
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productPost.author.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ExpandableText(
                        productPost.content,
                        expandText: 'See More',
                        collapseText: 'See Less',
                        maxLines: 2,
                        linkColor: colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(productPost.productUrl);
                        },
                        child: Text(
                          'Go To Product Page',
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
          productPost.image.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    productPost.image,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
