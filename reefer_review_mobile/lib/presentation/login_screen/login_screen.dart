import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/get_account_request.dart';
import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/presentation/home_screen/home_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/signup_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/profile_setup_screen.dart';
import 'package:reefer_review_mobile/presentation/shared/loading_modal.dart';
import 'package:reefer_review_mobile/repositories/account_repository/fake_account_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: BlocProvider(
              create: (context) =>
                  AccountBloc(FakeAccountRepository.repository),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        LoadingModal.display(context);
                      } else {
                        LoadingModal.dismiss(context);
                      }
                      if (state is AuthUserLoggedIn) {
                        BlocProvider.of<AccountBloc>(context).add(
                          GetAccountUsecase(
                            request: GetAccountRequest(state.user.userId),
                          ),
                        );
                      }
                    },
                  ),
                  BlocListener<AccountBloc, AccountState>(
                    listener: (context, state) {
                      if (state is AccountLoaded) {
                        if (state.account.displayName == null) {
                          Navigator.of(context)
                              .pushReplacementNamed(ProfileSetupScreen.route);
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.route);
                        }
                      }
                    },
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(reeferImage),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() {}),
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() {}),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        onPressed: _emailController.text.isEmpty ||
                                _passwordController.text.isEmpty
                            ? null
                            : _loginButtonPressed,
                        child: const Center(child: Text('Login')),
                      ),
                    ),
                    TextButton(
                      onPressed: _signUpPressed,
                      child: const Text('Sign Up'),
                    ),
                    TextButton(
                      onPressed: _forgotPasswordPressed,
                      child: const Text('Forgot Password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  _loginButtonPressed() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginUserUsecase(
        LoginUserRequest(_emailController.text, _passwordController.text),
      ),
    );
    // Login Bloc add login
  }

  _forgotPasswordPressed() {}

  _signUpPressed() {
    Navigator.of(context).pushNamed(SignUpScreen.route);
  }
}
