import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/bloc/auth_bloc/auth_bloc.dart';
import 'package:reefer_review_mobile/repositories/account_repository/fake_account_repository.dart';
import 'package:reefer_review_mobile/repositories/auth_repository/fake_auth_repository_impl.dart';
import 'package:reefer_review_mobile/res/themes/light_theme.dart';
import 'package:reefer_review_mobile/routes/router.dart' as router;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(FakeAuthRepository()),
        ),
        BlocProvider(
          create: (context) => AccountBloc(FakeAccountRepository()),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: router.generateRoute,
        theme: lightTheme,
      ),
    );
  }
}
