import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brands_screen.dart';
import 'package:reefer_review_mobile/presentation/home_screen/home_screen.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_screen.dart';
import 'package:reefer_review_mobile/presentation/shared/auth_checker.dart';
import 'package:reefer_review_mobile/presentation/shared/navigation_menu.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venues_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProductsScreen(),
    VenuesScreen(),
    BrandsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _navItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Product',
      icon: Icon(
        Icons.shopping_bag_outlined,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Venues',
      icon: Icon(
        Icons.storefront_outlined,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Brands',
      icon: Icon(
        Icons.sell_outlined,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final body = _widgetOptions.elementAt(_selectedIndex);
    return AuthChecker(
      child: Scaffold(
        drawer: const NavigationMenu(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: _navItems,
          onTap: _onItemTapped,
        ),
        appBar: _buildAppBar(_selectedIndex),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  AppBar _buildAppBar(int index) {
    switch (index) {
      case 0:
        return AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, 'Search Screen');
              },
            ),
          ],
        );

      default:
        return AppBar();
    }
  }
}
