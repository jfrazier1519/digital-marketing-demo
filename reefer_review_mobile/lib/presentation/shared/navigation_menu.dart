import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';

class NavigationMenu extends StatelessWidget {
  final String name;
  const NavigationMenu({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              0.6, // Adjust the width as needed
          child: Drawer(
            child: Container(
              color: colorScheme.background, // Set the background color here
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(name),
                    accountEmail: Text(''),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          size: 50, color: colorScheme.primary),
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: colorScheme.onSurface),
                    title: Text('Favorites',
                        style: TextStyle(color: colorScheme.onSurface)),
                    onTap: () {
                      // Update the state of the app
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: colorScheme.onSurface),
                    title: Text('Wishlist',
                        style: TextStyle(color: colorScheme.onSurface)),
                    onTap: () {
                      // Update the state of the app
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.diamond, color: colorScheme.onSurface),
                    title: Text('Crystals',
                        style: TextStyle(color: colorScheme.onSurface)),
                    onTap: () {
                      // Update the state of the app
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: colorScheme.onSurface),
                    title: Text('Account Settings',
                        style: TextStyle(color: colorScheme.onSurface)),
                    onTap: () {
                      // Update the state of the app
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  Divider(color: colorScheme.onSurface),
                  ListTile(
                    leading: Icon(Icons.logout, color: colorScheme.onSurface),
                    title: Text('Logout',
                        style: TextStyle(color: colorScheme.onSurface)),
                    onTap: () {
                      _logoutButtonPressed(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _logoutButtonPressed(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LogoutUserUsecase());
  }
}
