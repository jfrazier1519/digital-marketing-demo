import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/auth_bloc/auth_bloc.dart';
import 'package:reefer_review_mobile/bloc/feed_bloc/feed_bloc.dart'; // Ensure correct import for FeedBloc
import 'package:reefer_review_mobile/repositories/auth_repository/fake_auth_repository_impl.dart';
import 'package:reefer_review_mobile/repositories/post_repository.dart/fake_post_repository_impl.dart';
import 'package:reefer_review_mobile/res/themes/light_theme.dart';
import 'package:reefer_review_mobile/routes/router.dart' as router;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Fix key parameter

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(FakeAuthRepository())),
        BlocProvider(create: (context) => FeedBloc(FakePostRepository())),
      ],
      child: MaterialApp(
        onGenerateRoute: router.generateRoute,
        theme: lightTheme,
      ),
    );
  }
}
