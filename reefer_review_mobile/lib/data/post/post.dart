import 'package:flutter/material.dart';

abstract class Post {
  final int postId;
  final String author;
  final DateTime date;
  final String content;
  final String image; //url path to image

  Post(this.image,
      {required this.postId,
      required this.author,
      required this.date,
      required this.content});

  Widget displayContent();
}
