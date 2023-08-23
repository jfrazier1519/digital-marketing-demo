import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../data/models/requests/get_profile_by_id_request.dart';
import '../../presentation/shared/rounded_container.dart';
import '../../data/post/review_post.dart';
import '../../repositories/profile_repository/fake_profile_repository_impl.dart';

class ReviewPostWidget extends StatefulWidget {
  final ReviewPost reviewPost;

  const ReviewPostWidget({super.key, required this.reviewPost});

  @override
  _ReviewPostWidgetState createState() => _ReviewPostWidgetState();
}

class _ReviewPostWidgetState extends State<ReviewPostWidget> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
        create: (context) => ProfileBloc(FakeProfileRepositoryImpl.repository)
          ..add(GetProfileByIdUsecase(GetProfileByIdRequest(
              widget.reviewPost.authorId, widget.reviewPost.profileType))),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              final author = state.profile;

              return RoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(author.profileImage ?? ''),
                            radius: 25,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  author.profileName ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                ExpandableText(
                                  widget.reviewPost.content,
                                  expandText: 'See More',
                                  collapseText: 'See Less',
                                  maxLines: 2,
                                  linkColor: colorScheme.primary,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.star_border,
                                        color: colorScheme.primary),
                                    Text(
                                      ' ${widget.reviewPost.reviewStars} Stars',
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.reviewPost.image.isNotEmpty
                        ? SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.asset(
                              widget.reviewPost.image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            } else if (state is UserLoading) {
              return Center(child: CustomLoadingIndicator());
            } else {
              return Container(); // return some default or error UI
            }
          },
        ));
  }
}
