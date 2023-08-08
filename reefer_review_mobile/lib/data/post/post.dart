import 'package:flutter/material.dart';
import '../user.dart';

abstract class Post {
  final int postId;
  final User author;
  final DateTime date;
  final String content;
  final String image;

  Post({
    required this.postId,
    required this.author,
    required this.date,
    required this.content,
    required this.image,
  });

  Widget displayContent(BuildContext context);
}
