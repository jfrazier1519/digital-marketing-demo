import 'package:flutter/material.dart';
import '../shared/navigation_menu.dart';
import '../shared/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _selectedTabIndex = 0;
  bool _isSearching = false;

  //replace with the following and feed widgets when applicable
  _switchContent() {
    switch (_selectedTabIndex) {
      case 0:
        return Center(child: Text('Following Content'));
      case 1:
        return Center(child: Text('Feed Content'));
      default:
        return Center(child: Text('Following Content'));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              : Text('Home'),
          actions: [
            _isSearching
                ? IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    onPressed: () {},
                    child: Text('Add Post'),
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
                                ? Colors.green
                                : Colors.black,
                            decoration: _selectedTabIndex == 0
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ),
                      Text('|'),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedTabIndex = 1;
                          });
                        },
                        child: Text(
                          'Feed',
                          style: TextStyle(
                            color: _selectedTabIndex == 1
                                ? Colors.green
                                : Colors.black,
                            decoration: _selectedTabIndex == 1
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
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
