import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/event_post.dart';
import '../shared/custom_loading_indicator.dart';

class EventPostWidget extends StatefulWidget {
  final EventPost eventPost;

  const EventPostWidget({super.key, required this.eventPost});

  @override
  _EventPostWidgetState createState() => _EventPostWidgetState();
}

class _EventPostWidgetState extends State<EventPostWidget> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUserById(widget.eventPost.authorId));
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
                              widget.eventPost.content,
                              expandText: 'See More',
                              collapseText: 'See Less',
                              maxLines: 2,
                              linkColor: colorScheme.primary,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(widget.eventPost.eventUrl);
                              },
                              child: Text(
                                'Go To Event',
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
                widget.eventPost.image.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          widget.eventPost.image,
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
