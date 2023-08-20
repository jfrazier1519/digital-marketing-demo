import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/res/routes.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import 'package:reefer_review_mobile/data/post/post_feed_type.dart';
import 'package:reefer_review_mobile/repositories/post_repository.dart/fake_post_repository_impl.dart';
import '../../data/models/route_arguments/add_post_screen_arguments.dart';
import 'feed.dart';
import '../shared/navigation_menu.dart';
import '../shared/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, 'Search Screen');
                },
              ),
            ],
          ),
          drawer: const NavigationMenu(name: 'User name'),
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
                        Builder(
                          builder: (builderContext) => ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                addPostViewRoute,
                                arguments: AddPostScreenArguments(
                                  feedBloc:
                                      BlocProvider.of<FeedBloc>(builderContext),
                                ),
                              );
                            },
                            child: const Text('Add Post'),
                          ),
                        ),
                        Row(
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
                        const SizedBox(width: 50),
                      ],
                    ),
                  ),
                  Expanded(child: _switchContent()),
                ],
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
        ),
      ),
    );
  }
}
