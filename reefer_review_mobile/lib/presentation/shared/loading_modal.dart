import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.tertiary,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 100,
          width: 100,
          child: Center(
            child: CircularProgressIndicator(
              color: colorScheme
                  .primary, // Setting the color of the CircularProgressIndicator
            ),
          ),
        ),
      ),
    );
  }
}
