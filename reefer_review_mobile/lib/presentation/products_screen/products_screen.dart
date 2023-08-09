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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const NavigationMenu(name: 'User name'),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => showCategoriesModal(
                        context), // Updated to call new function
                    child: const Text('Product Category'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () =>
                        showSortModal(context), // Updated to call new function
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
