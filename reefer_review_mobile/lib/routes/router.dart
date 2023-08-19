import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/email_verification_screen_arguments.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brands_screen.dart';
import 'package:reefer_review_mobile/presentation/loading_screen/loading_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';
import 'package:reefer_review_mobile/presentation/products_screen/products_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/email_verification_screen/email_verification_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/signup_screen.dart';
import 'package:reefer_review_mobile/presentation/shared/loading_modal.dart';
import '../data/models/route_arguments/add_post_screen_arguments.dart';
import '../data/models/route_arguments/brand_details_screen_arguments.dart';
import '../data/models/route_arguments/product_details_screen_arguments.dart';
import '../data/models/route_arguments/venue_details_screen_arguments.dart';
import '../presentation/brands_screen/brand_details_screen/brand_details_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/signup_screen/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import '../presentation/post_screen/add_post_screen.dart';
import '../presentation/products_screen/products_details_screen/products_details_screen.dart';
import '../presentation/shared/undefined_view.dart';
import '../presentation/venue_screen/venue_details_screen/venue_details_screen.dart';
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
    case venuesScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const VenuesScreen());
    case brandsScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const BrandsScreen());
    case productDetailsScreenViewRoute:
      final args = settings.arguments as ProductDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: args.product,
        ),
      );
    case venuesScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const VenuesScreen());
    case venueDetailsScreenViewRoute:
      final args = settings.arguments as VenueDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => VenueDetailsScreen(venue: args.venue),
      );
    case brandsScreenViewRoute:
      return MaterialPageRoute(builder: (context) => const BrandsScreen());
    case brandDetailsScreenViewRoute:
      final args = settings.arguments as BrandDetailsScreenArguments;
      return MaterialPageRoute(
        builder: (context) => BrandDetailsScreen(brand: args.brand),
      );
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
    case addPostViewRoute:
      final args = settings.arguments as AddPostScreenArguments;
      return MaterialPageRoute(
        builder: (context) => AddPostScreen(feedBloc: args.feedBloc),
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
