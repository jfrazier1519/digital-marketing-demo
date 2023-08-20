import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/email_verification_screen_arguments.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brands_screen.dart';
import 'package:reefer_review_mobile/presentation/loading_screen/loading_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/email_verification_screen/email_verification_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/signup_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_screen/profile_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/product_experience_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/product_preferences_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/profile_setup_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/widgets/profile_setup_success_modal.dart';
import '../data/models/route_arguments/brand_details_screen_arguments.dart';
import '../data/models/route_arguments/product_details_screen_arguments.dart';
import '../data/models/route_arguments/venue_details_screen_arguments.dart';
import '../presentation/brands_screen/brand_details_screen/brand_details_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/signup_screen/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import '../presentation/products_screen/products_details_screen/products_details_screen.dart';
import '../presentation/shared/undefined_view.dart';
import '../presentation/venue_screen/venue_details_screen/venue_details_screen.dart';
import '../presentation/venue_screen/venues_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoadingScreen.route:
      return MaterialPageRoute(builder: (context) => const LoadingScreen());
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case HomeScreen.route:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case ProductsScreen.route:
      return MaterialPageRoute(builder: (context) => const ProductsScreen());
    case VenuesScreen.route:
      return MaterialPageRoute(builder: (context) => const VenuesScreen());
    case BrandsScreen.route:
      return MaterialPageRoute(builder: (context) => const BrandsScreen());
    case ProductDetailsScreen.route:
      final args = settings.arguments as ProductDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: args.product,
        ),
      );
    case VenueDetailsScreen.route:
      final args = settings.arguments as VenueDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => VenueDetailsScreen(venue: args.venue),
      );
    case BrandDetailsScreen.route:
      final args = settings.arguments as BrandDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => BrandDetailsScreen(brand: args.brand),
      );
    case SignUpScreen.route:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case TermsAndConditionsScreen.route:
      return MaterialPageRoute(
          builder: (context) => const TermsAndConditionsScreen());
    case EmailVerificationScreen.route:
      final args = settings.arguments as EmailVerifcationScreenArguments;
      return MaterialPageRoute(
        builder: (context) => EmailVerificationScreen(
          email: args.email,
        ),
      );

    case ProfileSetupScreen.route:
      return MaterialPageRoute(
        builder: (context) => const ProfileSetupScreen(),
      );
    case ProductPreferencesScreen.route:
      return MaterialPageRoute(
        builder: (context) => const ProductPreferencesScreen(),
      );
    case ProductExperiencesScreen.route:
      return MaterialPageRoute(
        builder: (context) => const ProductExperiencesScreen(),
      );
    case ProfileSetupSuccessModal.route:
      return ProfileSetupSuccessModal();
    case ProfileScreen.route:
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name ?? "",
        ),
      );
  }
}
