import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/res/colors.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  RoundedContainer(
      {required this.child, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
