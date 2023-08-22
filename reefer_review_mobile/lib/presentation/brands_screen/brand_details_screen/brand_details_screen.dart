import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import '../../../bloc/brand_bloc/brand_bloc.dart';
import '../../../bloc/feed_bloc/feed_bloc.dart';
import '../../../bloc/product_bloc/product_bloc.dart';
import '../../../bloc/user_bloc/user_bloc.dart';
import '../../../data/models/brand/brand.dart';
import '../../../data/models/user/user.dart';
import '../../../repositories/brand_repository/fake_brand_repository_impl.dart';
import '../../../repositories/post_repository.dart/fake_post_repository_impl.dart';
import '../../../repositories/product_repository/fake_product_repository_impl.dart';
import '../../../repositories/venue_repository/fake_venue_repository_impl.dart';
import '../../post/post_to_widget_converter.dart';
import '../../products_screen/product_widget.dart';
import '../../shared/category_bubble.dart';
import '../../shared/tab_button.dart';
import '../../venue_screen/venue_widget.dart';

class BrandDetailsScreen extends StatefulWidget {
  final Brand brand;

  static const route = '/brands/detail';

  const BrandDetailsScreen({super.key, required this.brand});

  @override
  _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  final int _currentIndex = 3;
  String _currentTab = "Info";

  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: state is UserLoaded
                ? BlocListener<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UserUpdated) {
                        final isFollowing = state.user.followedBrands
                            .contains(widget.brand.brandId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  isFollowing ? 'Followed' : 'Unfollowed')),
                        );
                      }
                    },
                    child: ListView(
                      children: [
                        if (widget.brand.image.isNotEmpty)
                          SizedBox(
                            height: 150.0,
                            child: Image.asset(widget.brand.image,
                                fit: BoxFit.cover),
                          ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.brand.name,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      BlocBuilder<UserBloc, UserState>(
                                        builder: (context, state) {
                                          bool isFollowed = false;
                                          User? currentUser;

                                          if (state is UserLoaded) {
                                            isFollowed = state
                                                .user.followedBrands
                                                .contains(widget.brand.brandId);
                                            currentUser = state.user;
                                            print(
                                                "UserLoaded state: userId = ${currentUser.uid}");
                                          } else if (state is UserUpdated) {
                                            isFollowed = state
                                                .user.followedBrands
                                                .contains(widget.brand.brandId);
                                            currentUser = state.user;
                                            print(
                                                "UserUpdated state: userId = ${currentUser.uid}");
                                          } else {
                                            print(
                                                "State is neither UserLoaded nor UserUpdated: state = $state");
                                          }

                                          return ElevatedButton(
                                            onPressed: () {
                                              if (currentUser != null) {
                                                context.read<UserBloc>().add(
                                                    ToggleFollowBrand(
                                                        currentUser,
                                                        widget.brand.brandId));
                                              } else {
                                                print(
                                                    "User data is not available");
                                              }
                                            },
                                            child: Text(isFollowed
                                                ? 'Unfollow'
                                                : 'Follow'),
                                          );
                                        },
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
                              const Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: widget.brand.categories
                                    .map((category) => CategoryBubble(
                                        text:
                                            category.toString().split('.').last,
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
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _currentTab,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Divider(thickness: 1, color: Colors.black),
                              _getContentForTab(),
                              const SizedBox(height: 20),
                              const Text(
                                "Feed",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Divider(thickness: 1, color: Colors.black),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Add Review"),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    FeedBloc(FakePostRepository())
                                      ..add(FetchPostsByAuthor(
                                          author: widget.brand.name)),
                                child: BlocBuilder<FeedBloc, FeedState>(
                                  builder: (context, state) {
                                    if (state is FeedLoading) {
                                      return const CircularProgressIndicator();
                                    } else if (state is FeedLoaded) {
                                      if (state.posts.isEmpty) {
                                        return const Text(
                                            'No posts available.');
                                      }
                                      return ListView.builder(
                                          itemCount: state.posts.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 0.0),
                                                child: PostToWidgetConverter
                                                    .convert(
                                                        state.posts[index]),
                                              ));
                                    } else {
                                      return const Text(
                                          'Something went wrong!');
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CustomLoadingIndicator(),
                  ));
      },
    );
  }

  Widget _getContentForTab() {
    switch (_currentTab) {
      case "Products":
        return BlocProvider(
          create: (context) =>
              ProductBloc(FakeProductRepository.productRepository)
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
        return BlocProvider(
          create: (context) =>
              BrandBloc(FakeBrandRepository(), FakeVenueRepository())
                ..add(FetchAssociatedVenues(widget.brand.brandId)),
          child: Center(
            child: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                if (state is BrandLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AssociatedVenuesLoaded) {
                  if (state.venues.isEmpty) {
                    return const Text('No venues available.');
                  }
                  return SingleChildScrollView(
                    child: ListView.builder(
                      itemCount: state.venues.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          VenueWidget(venue: state.venues[index]),
                    ),
                  );
                } else {
                  return const Text('Something went wrong!');
                }
              },
            ),
          ),
        );
      case "Crystals":
        // TODO: Return crystal-specific content
        break;
      default:
        return Text(widget.brand.description);
    }
    return const SizedBox.shrink();
  }
}
