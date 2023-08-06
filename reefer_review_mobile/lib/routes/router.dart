import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/loading_screen/loading_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';

import '../presentation/home/home_screen.dart';
import '../presentation/shared/undefined_view.dart';
import '../res/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loadingScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const LoadingScreen());
    case loginScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case homeScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name ?? "",
        ),
      );
  }
}
