import 'package:flutter/material.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/navigation_menu.dart';
import '../shared/category_modal.dart';
import '../shared/sort_modal.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentIndex = 1;
  bool _filterActive = false; // Tracks whether the filter is active
  bool _isCategorySelected =
      false; // Tracks whether the category button is selected
  bool _isSortSelected = false; // Tracks whether the sort button is selected

  final GlobalKey _categoryButtonKey = GlobalKey();
  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: _filterActive
                    ? colorScheme.outlineVariant
                    : Colors.white, // Highlighted when active
              ),
              onPressed: () {
                setState(() {
                  _filterActive = !_filterActive; // Toggle filter state
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const NavigationMenu(name: 'User name'),
        body: Column(
          children: [
            if (_filterActive) // Show only if filter is active
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      key: _categoryButtonKey,
                      onPressed: () {
                        if (_isCategorySelected) {
                          Navigator.pop(context);
                          setState(() {
                            _isCategorySelected = false;
                          });
                        } else {
                          setState(() {
                            _isCategorySelected = true;
                            _isSortSelected = false;
                          });
                          showCategoriesModal(context, _categoryButtonKey)
                              .then((_) {
                            setState(() {
                              _isCategorySelected = false;
                            });
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => _isCategorySelected
                                ? colorScheme.outlineVariant
                                : null), // Change color when selected
                      ),
                      child: const Text('Product Category'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      key: _sortButtonKey, // Add this line
                      onPressed: () {
                        if (_isSortSelected) {
                          Navigator.pop(context);
                          setState(() {
                            _isSortSelected = false;
                          });
                        } else {
                          setState(() {
                            _isCategorySelected = false;
                            _isSortSelected = true;
                          });
                          showSortModal(context, _sortButtonKey).then((_) {
                            setState(() {
                              _isSortSelected = false;
                            });
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => _isSortSelected
                                ? colorScheme.outlineVariant
                                : null), // Change color when selected
                      ),
                      child: const Text('Sort'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Center(
                child: Text('This is the products screen yo'),
              ),
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
    );
  }
}
