import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/repositories/review_repository/fake_review_repository_impl.dart';
import 'package:reefer_review_mobile/repositories/review_repository/review_repository.dart';

import '../../../bloc/review_bloc/review_bloc.dart';
import '../../../data/models/product/product.dart';
import '../../review/product_review_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => ReviewBloc(FakeReviewRepository())
        ..add(FetchReviewsForProduct(product.productId)),
      child: Scaffold(
          appBar: AppBar(),
          body: ListView(children: [
            // Product Image
            if (product.image.isNotEmpty)
              Container(
                height: 150.0, // Set the desired height here
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),

            // The rest of the content should be wrapped with Padding for consistent design.
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Ensures left alignment
                children: [
                  // Product Name and Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.loyalty_outlined,
                                color: colorScheme.primary),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border,
                                color: colorScheme.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Product Category
                  Text(
                    product.category,
                    style: TextStyle(color: colorScheme.primary),
                  ),

                  SizedBox(height: 10),

                  // Star Rating and Review Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star_border, color: colorScheme.primary),
                          SizedBox(width: 4),
                          Text(
                            "${product.rating} stars",
                            style: TextStyle(
                                color: colorScheme.primary, fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        "(${product.reviewCount} reviews)",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(height: 15),

                  // Product Description
                  Text(
                    product.description,
                    style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  SizedBox(height: 20),

                  // Price
                  Text(
                    "Price",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Divider(thickness: 1, color: Colors.black),

                  // Product Prices
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10.0,
                    children: product.prices.map((price) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 60.0,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(price.size),
                              Divider(thickness: 1, color: Colors.black),
                              Text('\$${price.value.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),

                  // Reviews Title
                  Text(
                    "Reviews",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Divider(thickness: 1, color: Colors.black),

                  BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (context, state) {
                      if (state is ReviewLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ReviewsLoaded) {
                        return ListView.builder(
                          itemCount: state.reviews.length,
                          shrinkWrap:
                              true, // Essential for inside another ListView
                          physics:
                              NeverScrollableScrollPhysics(), // To prevent nested scrolling
                          itemBuilder: (context, index) =>
                              ProductReviewWidget(review: state.reviews[index]),
                        );
                      } else {
                        return Center(child: Text('Something went wrong!'));
                      }
                    },
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
