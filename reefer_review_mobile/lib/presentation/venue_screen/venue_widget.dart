import 'package:flutter/material.dart';
import '../../data/venue.dart';

class VenueWidget extends StatelessWidget {
  final Venue venue;

  VenueWidget({required this.venue});

  @override
  Widget build(BuildContext context) {
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
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: venue.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                      venue.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(width: 100, height: 100),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  venue.name,
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
                          venue.rating.toString(),
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
                        '(${venue.reviewCount} reviews)',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Text(venue.type, style: TextStyle(color: colorScheme.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
