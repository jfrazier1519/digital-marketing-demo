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
      margin: const EdgeInsets.fromLTRB(15.0, 8.0, 0.0, 8.0),
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: image.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(width: 100, height: 100),
          ),
          const SizedBox(width: 20),

          // Details to the right of the image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section
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
                    ),
                  ],
                ),
                Text(category, style: TextStyle(color: colorScheme.primary)),
                const SizedBox(height: 5),
                Text(brand, style: TextStyle(color: colorScheme.primary)),
                const SizedBox(height: 5), // Space before the expandable text
                ExpandableText(
                  description,
                  expandText: 'See More',
                  collapseText: 'See Less',
                  maxLines: 1,
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
