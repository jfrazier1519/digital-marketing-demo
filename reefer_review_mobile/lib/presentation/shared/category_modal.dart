import 'package:flutter/material.dart';

void showCategoriesModal(BuildContext context) {
  var colorScheme = Theme.of(context).colorScheme;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10.0),
          backgroundColor: colorScheme.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text('Categories',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        categoryTile(context, 'Category 1'),
                        categoryTile(context, 'Category 2'),
                        categoryTile(context, 'Category 3'),
                        categoryTile(context, 'Category 4'),
                        categoryTile(context, 'Category 5'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget categoryTile(BuildContext context, String category) {
  return InkWell(
    onTap: () {
      print('Selected $category'); // Handle the category selection here
    },
    child: ListTile(
      title: Text(category),
    ),
  );
}
