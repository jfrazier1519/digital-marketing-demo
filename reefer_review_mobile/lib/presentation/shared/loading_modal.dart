import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevents back button
      child: Container(
        color: Colors.black.withOpacity(0.5), // Darken background
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
