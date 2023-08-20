import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brands_screen.dart';
import 'package:reefer_review_mobile/presentation/home_screen/home_screen.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_screen.dart';
import 'package:reefer_review_mobile/presentation/venue_screen/venues_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == currentIndex) {
            return;
          }
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
          }
          if (index == 1) {
            Navigator.of(context).pushReplacementNamed(ProductsScreen.route);
          }
          if (index == 2) {
            Navigator.of(context).pushReplacementNamed(VenuesScreen.route);
          }
          if (index == 3) {
            Navigator.of(context).pushReplacementNamed(BrandsScreen.route);
          } else {
            onTap(index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Venues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Brands',
          ),
        ],
      ),
    );
  }
}
