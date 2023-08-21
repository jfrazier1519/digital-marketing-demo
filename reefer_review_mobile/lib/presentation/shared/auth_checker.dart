import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserInitial) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
        }
      },
      child: child,
    );
  }
}
