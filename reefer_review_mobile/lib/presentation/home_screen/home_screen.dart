import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import 'package:reefer_review_mobile/data/post/post_feed_type.dart';
import 'package:reefer_review_mobile/repositories/post_repository.dart/fake_post_repository_impl.dart';
import 'feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;
  int _selectedTabIndex = 0;

  Widget _switchContent() {
    switch (_selectedTabIndex) {
      case 0:
        return const FeedScreen(feedType: PostFeedType.Following);
      case 1:
        return const FeedScreen(feedType: PostFeedType.Suggested);
      default:
        return const FeedScreen(feedType: PostFeedType.Following);
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => FeedBloc(FakePostRepository()),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedTabIndex = 0;
                                });
                              },
                              child: Text(
                                'Following',
                                style: TextStyle(
                                  color: _selectedTabIndex == 0
                                      ? colorScheme.primary
                                      : Colors.black,
                                  decoration: _selectedTabIndex == 0
                                      ? TextDecoration.underline
                                      : null,
                                ),
                              ),
                            ),
                            const Text('|'),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedTabIndex = 1;
                                });
                              },
                              child: Text(
                                'Suggested',
                                style: TextStyle(
                                  color: _selectedTabIndex == 1
                                      ? colorScheme.primary
                                      : Colors.black,
                                  decoration: _selectedTabIndex == 1
                                      ? TextDecoration.underline
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _switchContent()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
