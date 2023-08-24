import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/brand_details_screen_arguments.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brand_details_screen/brand_details_screen.dart';
import '../../data/models/brand/brand.dart';
import '../shared/category_bubble.dart';

class BrandWidget extends StatelessWidget {
  final Brand brand;

  const BrandWidget({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        BrandDetailsScreen.route,
        arguments: BrandDetailsScreenArguments(brand: brand),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
        ),
        margin: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              child: Image.asset(
                brand.profileImage!,
                width: 125,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      brand.profileName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star),
                            Text(
                              '${brand.rating} stars',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Text('(${brand.reviewCount}) Reviews')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        brand.categories.length,
                        (index) => CategoryBubble(
                            text: brand.categories[index]
                                .toString()
                                .split('.')
                                .last,
                            colorScheme: colorScheme),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
