import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/repositories/review_repository/fake_review_repository_impl.dart';

import '../../../bloc/review_bloc/review_bloc.dart';
import '../../../data/models/product/product.dart';
import '../../review/product_review_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  static const route = '/products/detail';

  const ProductDetailsScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final int _currentIndex = 1;

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
            SizedBox(
              height: 150.0,
              child: Image.asset(widget.product.image, fit: BoxFit.cover),
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
                      widget.product.name,
                      style: const TextStyle(
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
                Text(
                  widget.product.category,
                  style: TextStyle(color: colorScheme.primary),
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
                          "${widget.product.rating} stars",
                          style: TextStyle(
                              color: colorScheme.primary, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "(${widget.product.reviewCount} reviews)",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  widget.product.description,
                  style:
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                ),
                const SizedBox(height: 20),
                // Price
                const Text(
                  "Price",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Divider(thickness: 1, color: Colors.black),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10.0,
                  children: widget.product.prices.map((price) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 60.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(price.size),
                            const Divider(thickness: 1, color: Colors.black),
                            Text('\$${price.value.toStringAsFixed(0)}'),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Reviews",
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
                            ProductReviewWidget(review: state.reviews[index]),
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
      ),
    );
  }
}
