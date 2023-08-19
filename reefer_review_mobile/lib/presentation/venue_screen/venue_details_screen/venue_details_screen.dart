import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/review_bloc/review_bloc.dart';
import '../../../data/venue.dart';
import '../../../repositories/review_repository/fake_review_repository_impl.dart';
import '../../review/venue_review_widget.dart';
import '../../shared/bottom_nav_bar.dart';

class VenueDetailsScreen extends StatefulWidget {
  final Venue venue;

  const VenueDetailsScreen({super.key, required this.venue});

  @override
  _VenueDetailsScreenState createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => ReviewBloc(FakeReviewRepository())
        ..add(FetchReviewsForVenue(widget.venue.venueId)),
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          if (widget.venue.image.isNotEmpty)
            SizedBox(
              height: 150.0,
              child: Image.asset(widget.venue.image, fit: BoxFit.cover),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.venue.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border,
                          color: colorScheme.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_border, color: colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          "${widget.venue.rating} stars",
                          style: TextStyle(
                              color: colorScheme.primary, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "(${widget.venue.reviewCount} reviews)",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  widget.venue.description,
                  style:
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                ),
                const SizedBox(height: 20),
                // Add other venue-specific details here

                const Text(
                  "Feed",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Divider(thickness: 1, color: Colors.black),
                BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    if (state is ReviewLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ReviewsLoaded) {
                      return ListView.builder(
                        itemCount: state.reviews.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            VenueReviewWidget(review: state.reviews[index]),
                      );
                    } else {
                      return const Center(child: Text('Something went wrong!'));
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
