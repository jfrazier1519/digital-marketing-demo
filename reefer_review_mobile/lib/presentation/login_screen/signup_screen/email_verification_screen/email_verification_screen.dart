import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, required this.email});

  static const route = '/sign-up/email-verification';

  final String email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'An email verification link has been sent to $email. Please verify your email.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _backToLoginPressed(context),
                child: const Text('Back To Login'),
              ),
              TextButton(
                onPressed: () => _resendEmailVerificationLink(context),
                child: const Text('Resend Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _backToLoginPressed(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
  }

  _resendEmailVerificationLink(BuildContext context) {
    BlocProvider.of<AccountBloc>(context).add(
      SendEmailVerifcationLinkUseCase(
        SendEmailVerifcationLinkRequest(email),
      ),
    );
  }
}
