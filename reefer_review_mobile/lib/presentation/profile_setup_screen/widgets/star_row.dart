import 'package:flutter/material.dart';

class StarRow extends StatelessWidget {
  const StarRow({super.key, required this.rating, required this.onSubmit});

  final int rating;

  final Function(int rating) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          5,
          (index) => IconButton(
            onPressed: () => _starPressed(index),
            icon: Icon(
              rating > index ? Icons.star : Icons.star_outline,
              color: rating > index
                  ? Theme.of(context).colorScheme.onSecondary
                  : null,
            ),
            iconSize: 45,
          ),
        ),
      ),
    );
  }

  _starPressed(int index) {
    onSubmit(index + 1);
  }
}
