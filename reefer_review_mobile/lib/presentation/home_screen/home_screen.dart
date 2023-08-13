import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import 'package:reefer_review_mobile/data/post/post_feed_type.dart';
import 'package:reefer_review_mobile/repositories/post_repository.dart/fake_post_repository_impl.dart';
import 'feed.dart';
import '../post_screen/add_post_screen.dart';
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
  bool _isSearching = false;

  late FeedBloc feedBloc;

  @override
  void initState() {
    super.initState();
    feedBloc = FeedBloc(FakePostRepository());
  }

  @override
  void dispose() {
    feedBloc.close();
    super.dispose();
  }

  Widget _switchContent() {
    switch (_selectedTabIndex) {
      case 0:
        return FeedScreen(feedType: PostFeedType.Following);
      case 1:
        return FeedScreen(feedType: PostFeedType.Suggested);
      default:
        return FeedScreen(feedType: PostFeedType.Following);
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: feedBloc,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: _isSearching
                ? TextField(
                    onSubmitted: (value) {},
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 2.0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search...',
                    ),
                  )
                : const Text('Home'),
            actions: [
              _isSearching
                  ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isSearching = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isSearching = true;
                        });
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider.value(
                                value: feedBloc,
                                child: AddPostScreen(
                                  feedBloc: feedBloc,
                                  onClose: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ));
                          },
                          child: const Text('Add Post'),
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
