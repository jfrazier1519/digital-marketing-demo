import 'package:flutter/material.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/route_arguments/product_details_screen_arguments.dart';
import '../../../res/routes.dart';

class ProductPriceWidget extends StatelessWidget {
  final Product product;

  const ProductPriceWidget({Key? key, required this.product}) : super(key: key);

  String abbreviateString(String text, [int limit = 15]) {
    if (text.length <= limit) {
      return text;
    }
    return '${text.substring(0, limit)}...';
  }

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
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: colorScheme.tertiary,
          boxShadow: [
            BoxShadow(
              color: colorScheme.onBackground.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image
            Align(
              alignment: Alignment.topLeft,
              child: product.image.isNotEmpty
                  ? ClipRRect(
                      child: Image.asset(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(width: 50, height: 50),
            ),
            const SizedBox(width: 10),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    abbreviateString(product.name),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.category,
                    style: TextStyle(color: colorScheme.primary, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: product.prices.map((price) {
                  return Container(
                    margin: const EdgeInsets.only(left: 3),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 55.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 2),
                              child: Text(price.size,
                                  style: const TextStyle(fontSize: 12)),
                            ),
                            const Divider(thickness: 1, color: Colors.black),
                            Transform.translate(
                              offset: const Offset(0, -2),
                              child: Text(
                                '\$${price.value.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
