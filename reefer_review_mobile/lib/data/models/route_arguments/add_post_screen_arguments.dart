import 'package:reefer_review_mobile/bloc/auth_bloc/auth_bloc.dart';
import '../../../bloc/feed_bloc/feed_bloc.dart';

class AddPostScreenArguments {
  final FeedBloc feedBloc;

  AddPostScreenArguments({required this.feedBloc});
}
