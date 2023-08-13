import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../res/routes.dart';

class LoadingModal extends ModalRoute<Route> {
  static display(BuildContext context) {
    Navigator.of(context).pushNamed(loadingModalViewRoute);
  }

  static dismiss(BuildContext context) {
    if (ModalRoute.of(context)?.settings.name == loadingModalViewRoute) {
      Navigator.of(context).popUntil((route) => route is! LoadingModal);
    }
  }

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.2);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
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
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration.zero;
}
