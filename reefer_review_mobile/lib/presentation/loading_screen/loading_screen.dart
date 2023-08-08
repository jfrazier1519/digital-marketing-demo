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
  // A boolean flag to determine whether the navigation delay is complete
  bool _shouldNavigate = false;

  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  _goToLogin() async {
    // Wait for the delay to finish before setting the flag
    await Future.delayed(const Duration(seconds: 3));
    // Use setState to trigger a rebuild when the delay is complete
    setState(() {
      _shouldNavigate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check the flag in the build method
    if (_shouldNavigate) {
      // If the delay is complete, use a post-frame callback to execute the navigation
      // This ensures that the navigation doesn't cause a black screen issue
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, loginScreenViewRoute);
      });
    }

    // Rest of the build method as before
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(reeferImage),
          const SizedBox(height: 10),
          const Text(
            'Loading',
            style: TextStyle(
              fontFamily: 'Ranchers',
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 20,
            child: const LoadingIndicator(
              pause: false,
              indicatorType: Indicator.ballPulse,
              colors: [Colors.black],
            ),
          ),
        ],
      ),
    );
  }
}
