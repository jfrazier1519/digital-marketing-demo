import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:reefer_review_mobile/res/images.dart';
import 'package:reefer_review_mobile/res/routes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(reeferImage),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Loading',
            style: TextStyle(
              fontFamily: 'Ranchers',
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 20,
            child: const LoadingIndicator(
              pause: false,
              indicatorType: Indicator.ballPulse,
              colors: [
                Colors.black,
              ],
            ),
          ),
        ],
      ),
    );
  }

  _goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, loginScreenViewRoute);
  }
}
