import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../res/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthUserLoggedIn) {
                  Navigator.of(context)
                      .pushReplacementNamed(homeScreenViewRoute);
                }
              },
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
    Navigator.of(context).pushNamed(signupScreenViewRoute);
  }
}
