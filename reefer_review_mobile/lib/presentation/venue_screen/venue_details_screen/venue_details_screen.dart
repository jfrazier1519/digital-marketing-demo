import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venue_details_screen/product_price_widget.dart';
import '../../../bloc/review_bloc/review_bloc.dart';
import '../../../bloc/product_bloc/product_bloc.dart';
import '../../../data/venue.dart';
import '../../../repositories/product_repository/fake_product_repository_impl.dart';
import '../../../repositories/review_repository/fake_review_repository_impl.dart';
import '../../review/venue_review_widget.dart';

import '../../shared/bottom_nav_bar.dart';

class VenueDetailsScreen extends StatefulWidget {
  final Venue venue;

  static const route = '/venues/detail';
  const VenueDetailsScreen({super.key, required this.venue});

  @override
  _VenueDetailsScreenState createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReviewBloc(FakeReviewRepository())
            ..add(FetchReviewsForVenue(widget.venue.venueId)),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(FakeProductRepository.productRepository)
                ..add(FetchProductsByVenue(widget.venue.venueId)),
        ),
      ],
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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle the Follow functionality here
                          },
                          child: const Text('Follow'),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite_border,
                              color: colorScheme.primary),
                          onPressed: () {
                            // Handle the heart icon functionality here
                          },
                        ),
                      ],
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
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.venue.address,
                        style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.7)),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.copy,
                        color: colorScheme.primary,
                      ),
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.venue.address));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Address copied"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    // Handle the Check In functionality here
                  },
                  child: const Text('Check In'),
                ),
                const SizedBox(height: 10),
                // Price
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Divider(thickness: 1, color: Colors.black),

                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is ProductsLoaded) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10.0,
                        children: state.products.map((product) {
                          return ProductPriceWidget(product: product);
                        }).toList(),
                      );
                    } else {
                      return const Center(child: Text('Something went wrong!'));
                    }
                  },
                ),
                const SizedBox(height: 15),

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
