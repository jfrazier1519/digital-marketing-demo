import 'package:flutter/material.dart';
import '../../res/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == currentIndex) {
            return;
          }
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed(homeScreenViewRoute);
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
            icon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Venues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Brands',
          ),
        ],
      ),
    );
  }
}
