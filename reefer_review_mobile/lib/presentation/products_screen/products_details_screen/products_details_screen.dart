import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/repositories/review_repository/fake_review_repository_impl.dart';

import '../../../bloc/review_bloc/review_bloc.dart';
import '../../../data/models/product/product.dart';
import '../../review/product_review_widget.dart';
import '../../shared/bottom_nav_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => ReviewBloc(FakeReviewRepository())
        ..add(FetchReviewsForProduct(widget.product.productId)),
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          if (widget.product.image.isNotEmpty)
            Container(
              height: 150.0,
              child: Image.asset(widget.product.image, fit: BoxFit.cover),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                Text(
                  widget.product.category,
                  style: TextStyle(color: colorScheme.primary),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_border, color: colorScheme.primary),
                        SizedBox(width: 4),
                        Text(
                          "${widget.product.rating} stars",
                          style: TextStyle(
                              color: colorScheme.primary, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "(${widget.product.reviewCount} reviews)",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  widget.product.description,
                  style:
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                ),
                SizedBox(height: 20),
                // Price
                Text(
                  "Price",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1, color: Colors.black),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10.0,
                  children: widget.product.prices.map((price) {
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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
