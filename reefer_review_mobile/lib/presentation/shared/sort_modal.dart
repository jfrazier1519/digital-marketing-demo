import 'package:flutter/material.dart';

Future<void> showSortModal(BuildContext context) {
  return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Text('Sort', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              sortTile(context, 'Product'),
              sortTile(context, 'Brand'),
              sortTile(context, 'Rating'),
              sortTile(context, 'Reviews'),
            ],
          ),
        );
      });
}

Widget sortTile(BuildContext context, String sortOption) {
  return ListTile(
      title: Text(sortOption),
      onTap: () {
        // Implement the sorting logic based on the sortOption here
        print('Selected sort by $sortOption'); // For testing
      });
}
