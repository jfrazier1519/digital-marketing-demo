import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/add_post_screen_arguments.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/email_verification_screen_arguments.dart';
import 'package:reefer_review_mobile/presentation/loading_screen/loading_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/email_verification_screen/email_verification_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/signup_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/product_experience_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/product_preferences_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/profile_setup_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/widgets/profile_setup_success_modal.dart';
import 'package:reefer_review_mobile/presentation/shared/loading_modal.dart';

import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/signup_screen/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import '../presentation/post_screen/add_post_screen.dart';
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
    case profileSetupScreenViewRoute:
      return MaterialPageRoute(
        builder: (context) => const ProfileSetupScreen(),
      );
    case preferencesSetupScreenViewRoute:
      return MaterialPageRoute(
        builder: (context) => const ProductPreferencesScreen(),
      );
    case productExperienceViewRoute:
      return MaterialPageRoute(
        builder: (context) => const ProductExperiencesScreen(),
      );
    case profileSetupSuccessModalRoute:
      return ProfileSetupSuccessModal();
    default:
      return MaterialPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name ?? "",
        ),
      );
  }
}
