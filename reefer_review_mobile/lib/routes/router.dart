import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/email_verification_screen_arguments.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brands_screen.dart';
import 'package:reefer_review_mobile/presentation/loading_screen/loading_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/email_verification_screen/email_verification_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/signup_screen.dart';
import 'package:reefer_review_mobile/presentation/shared/loading_modal.dart';

import '../data/models/route_arguments/product_details_screen_arguments.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/signup_screen/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import '../presentation/products_screen/products_details_screen/products_details_screen.dart';
import '../presentation/shared/undefined_view.dart';
import '../presentation/venue_screen/venues_screen.dart';
import '../res/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loadingScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const LoadingScreen());
    case loginScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case homeScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case productsScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const ProductsScreen());
    case productDetailsScreenViewRoute:
      final args = settings.arguments as ProductDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: args.product,
        ),
      );
    case venuesScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const VenuesScreen());
    case brandsScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const BrandsScreen());
    case signupScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case termsAndConditionsViewRoute:
      return MaterialPageRoute(
          builder: (context) => const TermsAndConditionsScreen());
    case emailVerificationViewRoute:
      final args = settings.arguments as EmailVerifcationScreenArguments;
      return MaterialPageRoute(
        builder: (context) => EmailVerificationScreen(
          email: args.email,
        ),
      );
    case loadingModalViewRoute:
      return LoadingModal();
    default:
      return MaterialPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name ?? "",
        ),
      );
  }
}
