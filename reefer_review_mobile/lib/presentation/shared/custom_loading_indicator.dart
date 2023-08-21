import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Loading',
            style: TextStyle(
              fontFamily: 'Ranchers',
              fontSize: 30,
              color: Colors.black,
            ),
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
}
