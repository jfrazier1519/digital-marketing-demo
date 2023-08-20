import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/res/routes.dart';

class ProfileSetupSuccessModal extends ModalRoute {
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 200,
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.75),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Success you have setup your profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: ElevatedButton(
                  onPressed: () => _goToHomePressed(context),
                  child: const Center(child: Text('Go To Home')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration.zero;

  _goToHomePressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(homeScreenViewRoute);
  }
}
