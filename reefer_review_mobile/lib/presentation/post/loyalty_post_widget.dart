import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/loyalty_post.dart';
import '../shared/custom_loading_indicator.dart';

class LoyaltyPostWidget extends StatefulWidget {
  final LoyaltyPost loyaltyPost;

  const LoyaltyPostWidget({super.key, required this.loyaltyPost});

  @override
  _LoyaltyPostWidgetState createState() => _LoyaltyPostWidgetState();
}

class _LoyaltyPostWidgetState extends State<LoyaltyPostWidget> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUserById(widget.loyaltyPost.authorId));
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
                              widget.loyaltyPost.content,
                              expandText: 'See More',
                              collapseText: 'See Less',
                              maxLines: 2,
                              linkColor: colorScheme.primary,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.diamond,
                                  color: colorScheme.primary,
                                ),
                                Text(
                                  ' ${widget.loyaltyPost.crystals} crystals',
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                widget.loyaltyPost.image.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          widget.loyaltyPost.image,
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
