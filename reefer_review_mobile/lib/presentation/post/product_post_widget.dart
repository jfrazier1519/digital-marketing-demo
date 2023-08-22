import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/product_post.dart';

class ProductPostWidget extends StatefulWidget {
  final ProductPost productPost;

  const ProductPostWidget({super.key, required this.productPost});

  @override
  _ProductPostWidgetState createState() => _ProductPostWidgetState();
}

class _ProductPostWidgetState extends State<ProductPostWidget> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUserById(widget.productPost
        .authorId)); // Assuming the ProductPost has an authorId property
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserLoaded) {
          final author = state.user;

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
                        backgroundImage: AssetImage(author.photoUrl ?? ''),
                        radius: 25,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              author.displayName ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                                Navigator.of(context)
                                    .pushNamed(widget.productPost.productUrl);
                              },
                              child: Text(
                                'Go To Product Page',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
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
          return Center(child: CustomLoadingIndicator());
        } else {
          return Container(); // return some default or error UI
        }
      },
    );
  }
}
