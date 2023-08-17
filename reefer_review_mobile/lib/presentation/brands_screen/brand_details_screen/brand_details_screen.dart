import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/product_bloc/product_bloc.dart';
import '../../../data/models/brand.dart';
import '../../../repositories/product_repository/fake_product_repository_impl.dart';
import '../../products_screen/product_widget.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../shared/tab_button.dart';

class BrandDetailsScreen extends StatefulWidget {
  final Brand brand;

  const BrandDetailsScreen({required this.brand});

  @override
  _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  int _currentIndex = 3;
  String _currentTab = "Info";

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          if (widget.brand.image.isNotEmpty)
            SizedBox(
              height: 150.0,
              child: Image.asset(widget.brand.image, fit: BoxFit.cover),
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
                      widget.brand.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Follow'),
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
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: widget.brand.categories
                      .map((category) => _CategoryBubble(
                          text: category.toString().split('.').last,
                          colorScheme: colorScheme))
                      .toList(),
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 10.0,
                  children: [
                    TabButton(
                        text: "Info",
                        isSelected: _currentTab == "Info",
                        onTap: () {
                          setState(() {
                            _currentTab = "Info";
                          });
                        }),
                    TabButton(
                        text: "Products",
                        isSelected: _currentTab == "Products",
                        onTap: () {
                          setState(() {
                            _currentTab = "Products";
                          });
                        }),
                    TabButton(
                        text: "Venues",
                        isSelected: _currentTab == "Venues",
                        onTap: () {
                          setState(() {
                            _currentTab = "Venues";
                          });
                        }),
                    TabButton(
                        text: "Events",
                        isSelected: _currentTab == "Events",
                        onTap: () {
                          setState(() {
                            _currentTab = "Events";
                          });
                        }),
                    TabButton(
                        text: "Crystals",
                        isSelected: _currentTab == "Crystals",
                        onTap: () {
                          setState(() {
                            _currentTab = "Crystals";
                          });
                        }),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _currentTab,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Divider(color: colorScheme.primary),
                _getContentForTab(),
                const SizedBox(height: 20),
                const Text(
                  "Feed",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Divider(color: colorScheme.primary),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Add Review"),
                ),
                // TODO: Insert brand-specific feed here
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getContentForTab() {
    switch (_currentTab) {
      case "Products":
        return BlocProvider(
          create: (context) => ProductBloc(FakeProductRepository())
            ..add(FetchProductsByBrand(widget.brand.name)),
          child: Center(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ProductsLoaded) {
                  if (state.products.isEmpty) {
                    return const Text('No products available.');
                  }
                  return SingleChildScrollView(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ProductWidget(product: state.products[index]),
                    ),
                  );
                } else {
                  return const Text('Something went wrong!');
                }
              },
            ),
          ),
        );

      case "Venues":
        // TODO: Return venue-specific content
        break;
      case "Events":
        // TODO: Return event-specific content
        break;
      case "Crystals":
        // TODO: Return crystal-specific content
        break;
      default:
        return Text("Info about brand");
    }
    return SizedBox.shrink();
  }
}

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return CircularProgressIndicator();
        } else if (state is ProductsLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.products[index].name),
                // Add other details of the product as needed
              );
            },
          );
        } else {
          return Text("Error loading products");
        }
      },
    );
  }
}

class _CategoryBubble extends StatelessWidget {
  final String text;
  final ColorScheme colorScheme;

  const _CategoryBubble({required this.text, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
