import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final double? width;

  const TabButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              return isSelected
                  ? colorScheme.outlineVariant
                  : colorScheme.primary;
            },
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
