import 'package:flutter/material.dart';

import '../../../../res/colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Terms and Conditions',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: primaryBackground),
          ),
        ),
      ),
    );
  }
}
