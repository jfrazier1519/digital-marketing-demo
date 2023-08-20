import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/register_user_request.dart';
import 'package:reefer_review_mobile/data/models/route_arguments/email_verification_screen_arguments.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/email_verification_screen/email_verification_screen.dart';
import 'package:reefer_review_mobile/presentation/login_screen/signup_screen/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import 'package:reefer_review_mobile/presentation/shared/loading_modal.dart';
import 'package:reefer_review_mobile/repositories/account_repository/fake_account_repository.dart';
import 'package:reefer_review_mobile/res/colors.dart';
import 'package:reefer_review_mobile/res/regex.dart' as regex;

import '../../../res/files.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const route = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _idController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _stateController = TextEditingController();
  DateTime? _dob;

  final _formKey = GlobalKey<FormState>();
  List<String> states = [];

  bool hasAgreedToTemsAndConditions = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _idController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _stateController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getStates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountLoading) {
          LoadingModal.display(context);
        } else {
          LoadingModal.dismiss(context);
        }
        if (state is AccountRequestSuccessful) {
          Navigator.of(context).pushNamed(
            EmailVerificationScreen.route,
            arguments: EmailVerifcationScreenArguments(_emailController.text),
          );
        }
      },
      builder: (context, state) {
        return BlocProvider(
          create: (context) => AccountBloc(FakeAccountRepository.repository),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Signup',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: primaryBackground),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: _checkIfValidEmail,
                          decoration: const InputDecoration(
                            labelText: 'Email*',
                          ),
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: _checkIfValidPassword,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password*',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: _checkConfirmPassword,
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password*',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: _checkIfItsAState,
                          controller: _stateController,
                          decoration: const InputDecoration(
                            labelText: 'State*',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'In some states you may be required to have a medical card. Please Enter that information.',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputDatePickerFormField(
                          initialDate: _dob,
                          errorInvalidText:
                              'Must be at least 18 years or older to signup',
                          fieldLabelText: "DOB*",
                          firstDate: _getYearsAgo(100),
                          lastDate: _getYearsAgo(18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: _checkIfEmpty,
                          decoration: const InputDecoration(
                            labelText: 'ID#*',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: _checkIfEmpty,
                          decoration: const InputDecoration(
                            labelText: 'First Name*',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: _checkIfEmpty,
                          decoration: const InputDecoration(
                            labelText: 'Last Name*',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormField<bool>(
                            initialValue: hasAgreedToTemsAndConditions,
                            validator: _checkTermsAndConditions,
                            builder: (formState) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: hasAgreedToTemsAndConditions,
                                          onChanged: (value) {
                                            setState(() {
                                              hasAgreedToTemsAndConditions =
                                                  value ?? false;
                                            });
                                          }),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'I agree to the ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = _goToTermsOfService,
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: secondaryGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              text: 'terms and conditions',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (formState.hasError)
                                    Text(
                                      formState.errorText ?? "",
                                      style: Theme.of(context)
                                          .inputDecorationTheme
                                          .errorStyle,
                                    ),
                                ],
                              );
                            }),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ElevatedButton(
                              onPressed: () => _signUpPressed(context),
                              child: const Center(child: Text('Sign Up'))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? _checkIfEmpty(String? value) {
    return value?.isEmpty ?? true ? "Please enter a value" : null;
  }

  String? _checkIfValidEmail(String? value) {
    if (!regex.emailValidation.hasMatch(value ?? "")) {
      return "Invalid email format please check your spelling and try again.";
    }
    return null;
  }

  String? _checkIfValidPassword(String? value) {
    if (!regex.passwordValidation.hasMatch(value ?? '')) {
      return "Invalid password. Password must be between 12-16 character and contain at least one capital letter, one number, and one special character.";
    }
    return null;
  }

  String? _checkConfirmPassword(String? value) {
    if (value != _passwordController.text || value!.isEmpty) {
      return "Passwords do not match.";
    }
    return null;
  }

  String? _checkTermsAndConditions(bool? value) {
    if (hasAgreedToTemsAndConditions) {
      return null;
    } else {
      return "Please accept the terms and conditions";
    }
  }

  String? _checkIfItsAState(String? value) {
    if (states.contains(value?.toLowerCase())) {
      return null;
    } else {
      return "Please enter a valid U.S State";
    }
  }

  _signUpPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AccountBloc>(context).add(
        RegisterUserUseCase(
          RegisterUserRequest(
            email: _emailController.text,
            password: _passwordController.text,
            state: _stateController.text,
            dob: _dob,
            id: _idController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
          ),
        ),
      );
    }
  }

  _goToTermsOfService() {
    Navigator.of(context).pushNamed(TermsAndConditionsScreen.route);
  }

  DateTime _getYearsAgo(int years) {
    return DateTime.now().subtract(Duration(days: (365 * years)));
  }

  _getStates() async {
    final statesString = await rootBundle.loadString(statesFile);
    states = statesString.split('\n');
    states = states.map((e) {
      final parts = e.split(',');
      return parts[0].toLowerCase();
    }).toList();
  }
}
