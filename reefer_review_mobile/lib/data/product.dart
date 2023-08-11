import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart'; // Ensure this is imported

class Product {
  final int productId;
  final String name;
  final String category;
  final String strain;
  final String brand;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;

  Product({
    required this.productId,
    required this.name,
    required this.category,
    required this.strain,
    required this.brand,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
  });

  Widget displayContent(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: colorScheme.tertiary, // Background color
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Row(
        children: [
          // Image on the far left
          image.isNotEmpty
              ? SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          const SizedBox(width: 20),

          // Details to the right of the image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: colorScheme.primary),
                        ),
                        const SizedBox(width: 5),
                        Icon(Icons.star_border,
                            color: colorScheme.primary, size: 30),
                      ],
                    )
                  ],
                ),
                Text(category, style: TextStyle(color: colorScheme.primary)),
                const SizedBox(height: 5),
                Text(brand, style: TextStyle(color: colorScheme.primary)),
                const SizedBox(height: 5),
                ExpandableText(
                  description,
                  expandText: 'See More',
                  collapseText: 'See Less',
                  maxLines: 1, // Limit to 1 line before expansion
                  linkColor: colorScheme.primary,
                  style:
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
