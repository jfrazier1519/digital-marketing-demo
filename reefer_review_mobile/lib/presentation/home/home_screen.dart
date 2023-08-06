import 'package:flutter/material.dart';
import '../shared/navigation_menu.dart'; // Adjust the path to import NavigationMenu

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: NavigationMenu(
            name: 'User name'), // Replace 'User name' with actual user name
        body: Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}
