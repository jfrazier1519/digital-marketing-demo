import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brand_details_screen/brand_details_screen.dart';
import '../../data/models/brand/brand.dart';
import '../../data/models/route_arguments/brand_details_screen_arguments.dart';
import '../shared/category_bubble.dart';

class BrandWidget extends StatelessWidget {
  final Brand brand;

  const BrandWidget({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            BrandDetailsScreen.route,
            arguments: BrandDetailsScreenArguments(brand: brand),
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
                )
              ],
            ),
            child: Row(children: [
              Align(
                alignment: Alignment.topLeft,
                child: brand.image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        child: Image.asset(
                          brand.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const SizedBox(width: 100, height: 100),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      brand.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star_border,
                                color: colorScheme.primary, size: 18),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              brand.rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: colorScheme.primary),
                            ),
                            Text(" Stars",
                                style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            '(${brand.reviewCount} reviews)',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: brand.categories
                          .map((category) => CategoryBubble(
                              text: category.toString().split('.').last,
                              colorScheme: colorScheme))
                          .toList(),
                    )
                  ],
                ),
              )
            ])));
  }
}
