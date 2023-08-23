import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:reefer_review_mobile/bloc/profile/profile_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/get_profile_by_id_request.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_details_screen/products_details_screen.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_screen.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import 'package:reefer_review_mobile/repositories/product_repository/fake_product_repository_impl.dart';
import 'package:reefer_review_mobile/repositories/profile_repository/fake_profile_repository_impl.dart';
import '../../bloc/product_bloc/product_bloc.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../data/models/route_arguments/product_details_screen_arguments.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/product_post.dart';

class ProductPostWidget extends StatefulWidget {
  final ProductPost productPost;

  const ProductPostWidget({super.key, required this.productPost});

  @override
  _ProductPostWidgetState createState() => _ProductPostWidgetState();
}

class _ProductPostWidgetState extends State<ProductPostWidget> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(FakeProfileRepositoryImpl.repository)
            ..add(GetProfileByIdUsecase(GetProfileByIdRequest(
                widget.productPost.authorId, widget.productPost.profileType))),
        ),
        BlocProvider<ProductBloc>(
          create: (context) =>
              ProductBloc(FakeProductRepository.productRepository)
                ..add(FetchProductsById(widget.productPost.productId)),
        ),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final author = state.profile;

            return RoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(author.profileImage ?? ''),
                          radius: 25,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                author.profileName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ExpandableText(
                                widget.productPost.content,
                                expandText: 'See More',
                                collapseText: 'See Less',
                                maxLines: 2,
                                linkColor: colorScheme.primary,
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  context.read<ProductBloc>().add(
                                      FetchProductsById(
                                          widget.productPost.productId));
                                },
                                child: BlocBuilder<ProductBloc, ProductState>(
                                  builder: (context, state) {
                                    if (state is ProductLoaded) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            ProductDetailsScreen.route,
                                            arguments:
                                                ProductDetailsScreenArguments(
                                                    product: state.product),
                                          );
                                        },
                                        child: Text(
                                          'Go To Product Page',
                                          style: TextStyle(
                                            color: colorScheme.primary,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      );
                                    }
                                    // Now, if the product isn't loaded yet, it won't display anything
                                    return SizedBox.shrink();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.productPost.image.isNotEmpty
                      ? SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Image.asset(
                            widget.productPost.image,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          } else if (state is UserLoading) {
            return const Center(child: CustomLoadingIndicator());
          } else {
            return Container(); // return some default or error UI
          }
        },
      ),
    );
  }
}
