import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/login_screen/login_screen.dart';

class UndefinedView extends StatelessWidget {
  final String name;
  const UndefinedView({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Route for $name is not defined',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.route, (route) => false);
                },
                child: const Text(
                  "Go Home",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
