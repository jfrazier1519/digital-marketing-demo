import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/profile_screen/profile_screen.dart';

import '../../data/models/profile/profile.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profile, this.radius = 50});

  final Profile profile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _photoTapped(context),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundImage: profile.profileImage != null
            ? AssetImage(profile.profileImage!)
            : null,
        child: profile.profileImage == null
            ? Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: radius * 1.5,
              )
            : null,
      ),
    );
  }

  _photoTapped(BuildContext context) {
    Navigator.pushNamed(context, ProfileScreen.route);
  }
}
