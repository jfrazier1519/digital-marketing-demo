import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../../data/models/product/product.dart';
import '../../data/models/route_arguments/product_details_screen_arguments.dart';
import '../../res/routes.dart';
class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          productDetailsScreenViewRoute,
          arguments: ProductDetailsScreenArguments(product: product),
        );
      },
      child: Container(
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
            ),
          ],
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: product.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                        product.image,
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
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Text(
                            product.rating.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: colorScheme.primary),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.star_border,
                              color: colorScheme.primary,
                              size: 20), // Reduced size for better fit
                        ],
                      ),
                    ],
                  ),
                  Text(product.category,
                      style: TextStyle(color: colorScheme.primary)),
                  const SizedBox(height: 5),
                  Text(product.brand,
                      style: TextStyle(color: colorScheme.primary)),
                  const SizedBox(height: 5),
                  ExpandableText(
                    product.description,
                    expandText: 'See More',
                    collapseText: 'See Less',
                    maxLines: 1,
                    linkColor: colorScheme.primary,
                    style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
