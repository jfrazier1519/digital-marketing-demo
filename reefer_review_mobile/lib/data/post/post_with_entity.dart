import 'package:reefer_review_mobile/data/post/post.dart';

import '../models/profile/profile.dart';

class PostWithEntity {
  final Post post;
  final Profile? entity;

  PostWithEntity({required this.post, this.entity});
}
