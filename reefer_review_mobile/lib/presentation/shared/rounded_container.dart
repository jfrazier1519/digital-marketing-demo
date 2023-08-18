import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin; // Added this line

  const RoundedContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ), // Added this line
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: margin, // Updated this line
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
