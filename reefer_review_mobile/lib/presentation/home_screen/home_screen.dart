import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/res/routes.dart';
import '../shared/navigation_menu.dart';
import '../shared/bottom_nav_bar.dart';
import './following_feed.dart';
import './suggested_feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _selectedTabIndex = 0;
  bool _isSearching = false;

  _switchContent() {
    switch (_selectedTabIndex) {
      case 0:
        return const FollowingFeedScreen();
      case 1:
        return const SuggestedFeedScreen();
      default:
        return const FollowingFeedScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  onSubmitted: (value) {
                    // Handle the search operation here
                  },
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
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          addPostViewRoute); // Use pushNamed instead of pushReplacementNamed
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
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
