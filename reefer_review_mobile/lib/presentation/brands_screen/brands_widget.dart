import 'package:flutter/material.dart';
import '../../data/models/brand.dart';
import '../../data/models/route_arguments/brand_details_screen_arguments.dart';
import '../../res/routes.dart';

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
            brandDetailsScreenViewRoute,
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
                          fit: BoxFit.cover,
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
                          .map((category) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  category.toString().split('.').last,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              )
            ])));
  }
}
