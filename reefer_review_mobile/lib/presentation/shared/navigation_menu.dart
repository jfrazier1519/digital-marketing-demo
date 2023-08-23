import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/shared/profile_image.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import '../../bloc/user_bloc/user_bloc.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: state is UserLoaded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DrawerHeader(
                        decoration: BoxDecoration(color: colorScheme.primary),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                ProfileImage(profile: state.user),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  state.user.displayName ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          onTap: () =>
                              _onSubmit(context, NavMenuItem.navItems[index]),
                          leading: Icon(
                            NavMenuItem.navItems[index].icon,
                          ),
                          title: Text(
                            NavMenuItem.navItems[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        separatorBuilder: _buildSeperator,
                        itemCount: NavMenuItem.navItems.length,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CustomLoadingIndicator(),
                ),
        );
      },
    );
  }

  Widget _buildSeperator(BuildContext context, int index) {
    final navItem = NavMenuItem.navItems[index];
    if (navItem.title.toLowerCase() == 'account settings') {
      return const Divider();
    }
    return const SizedBox(
      height: 20,
    );
  }

  _logoutButtonPressed(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LogoutUserUsecase());
  }

  _onSubmit(BuildContext context, NavMenuItem item) {
    switch (item.title.toLowerCase()) {
      case 'logout':
        _logoutButtonPressed(context);
      default:
        Navigator.of(context).pop();
    }
  }
}

class NavMenuItem {
  final String title;
  final IconData icon;

  static final navItems = [
    NavMenuItem('Favorites', Icons.favorite),
    NavMenuItem('Wishlist', Icons.loyalty),
    NavMenuItem('Crystals', Icons.diamond),
    NavMenuItem('Account Settings', Icons.settings),
    NavMenuItem('Logout', Icons.logout),
  ];

  NavMenuItem(this.title, this.icon);
}
