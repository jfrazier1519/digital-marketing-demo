import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/presentation/post/product_post_widget.dart';
import 'package:reefer_review_mobile/presentation/post/review_post_widget.dart';
import '../../data/post/event_post.dart';
import '../../data/post/loyalty_post.dart';
import '../../data/post/post.dart';
import '../../data/post/product_post.dart';
import '../../data/post/review_post.dart';
import './event_post_widget.dart';
import 'loyalty_post_widget.dart';

class PostToWidgetConverter {
  static Widget convert(Post post) {
    switch (post.runtimeType) {
      case EventPost:
        return EventPostWidget(eventPost: post as EventPost);
      case LoyaltyPost:
        return LoyaltyPostWidget(loyaltyPost: post as LoyaltyPost);
      case ProductPost:
        return ProductPostWidget(productPost: post as ProductPost);
      case ReviewPost:
        return ReviewPostWidget(reviewPost: post as ReviewPost);
      default:
        return const Text('Unknown post type');
    }
  }
}
