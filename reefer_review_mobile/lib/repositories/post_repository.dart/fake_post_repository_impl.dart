import 'package:reefer_review_mobile/data/models/user/user.dart';
import 'package:reefer_review_mobile/repositories/post_repository.dart/post_repository.dart';
import 'package:reefer_review_mobile/repositories/utilities/entity_dispatcher.dart';
import '../../data/models/profile/profile.dart';
import '../../data/post/post.dart';
import '../../data/post/event_post.dart';
import '../../data/post/loyalty_post.dart';
import '../../data/post/post_with_entity.dart';
import '../../data/post/product_post.dart';
import '../../data/post/review_post.dart';
import 'package:reefer_review_mobile/res/images.dart';
import '../../data/post/post_feed_type.dart';
import '../brand_repository/brand_repository.dart';
import '../brand_repository/fake_brand_repository_impl.dart';
import '../user_repository/fake_user_repository_impl.dart';
import '../user_repository/user_repository.dart';
import '../venue_repository/fake_venue_repository_impl.dart';
import '../venue_repository/venue_repository.dart';

class FakePostRepository extends PostRepository {
  static final PostRepository repository = FakePostRepository._internal(
    FakeUserRepository.repository,
    FakeBrandRepository.repository,
    FakeVenueRepository.repository,
  );
  List<Post> _allPosts = [];
  final EntityDispatcher entityDispatcher;

  FakePostRepository._internal(UserRepository userRepo,
      BrandRepository brandRepo, VenueRepository venueRepo)
      : entityDispatcher = EntityDispatcher(
            userRepo: userRepo, brandRepo: brandRepo, venueRepo: venueRepo),
        _allPosts = [
          EventPost(
            postId: '2',
            authorId: '1',
            date: DateTime.now(),
            content:
                'This is an event post. Im going to keep adding words here until I run out of things to say. Ill just keep going and going and going and going. alright. done now. hopefully. maybe? please be done',
            image: dummyEventPostImage,
            eventUrl: 'event_screen_route',
            profileType: ProfileType.UserProfile,
          ),
          LoyaltyPost(
              postId: '3',
              authorId: '1',
              date: DateTime.now(),
              content: 'This is a loyalty post.',
              image: dummyLoyaltyPostImage,
              crystals: '5',
              profileType: ProfileType.UserProfile),
          ProductPost(
              postId: '4',
              authorId: '1',
              date: DateTime.now(),
              content: 'This is a product post.',
              image: dummyProductPostImage,
              productUrl: 'product_screen_route',
              productId: '1',
              profileType: ProfileType.UserProfile),
          ReviewPost(
              postId: '5',
              authorId: '1',
              date: DateTime.now(),
              content: 'This is a review post.',
              image: dummyReviewPostImage,
              reviewStars: 4.5,
              profileType: ProfileType.UserProfile),
          ProductPost(
              postId: '6',
              authorId: '1',
              date: DateTime.now(),
              content: 'This is a product post.',
              image: product4,
              productUrl: 'product_screen_route',
              productId: '4',
              profileType: ProfileType.BrandProfile),
        ];

  List<Post> get _followingPosts {
    return _allPosts
        .where((post) => post is! ProductPost && post is! EventPost)
        .toList();
  }

  List<Post> get _suggestedPosts {
    return _allPosts
        .where((post) => post is ProductPost || post is EventPost)
        .toList();
  }

  @override
  Future<List<Post>> getFeedPosts({PostFeedType? feedType, User? user}) async {
    switch (feedType) {
      case PostFeedType.Following:
        return _allPosts.where((post) {
          bool isFollowedBrand = post.profileType == ProfileType.BrandProfile &&
              (user?.followedBrands.contains(post.authorId) ?? false);
          bool isFollowedVenue = post.profileType == ProfileType.VenueProfile &&
              (user?.followedVenues.contains(post.authorId) ?? false);
          bool isFollowedUser = post.profileType == ProfileType.UserProfile &&
              (user?.followedUsers.contains(post.authorId) ?? false);

          return isFollowedBrand || isFollowedVenue || isFollowedUser;
        }).toList();
      case PostFeedType.Suggested:
        return _suggestedPosts;
      default:
        return _allPosts;
    }
  }

  @override
  Future<void> addPost(Post post) async {
    _allPosts.add(post);
  }

  @override
  Future<void> updatePost(Post post) async {
    int index = _allPosts.indexWhere((p) => p.postId == post.postId);
    if (index != -1) {
      _allPosts[index] = post;
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    _allPosts.removeWhere((p) => p.postId == postId);
  }

  @override
  Future<List<Post>> getPostsByProfileIdAndType(
      String authorId, ProfileType type) async {
    final posts = _allPosts
        .where((post) => post.authorId == authorId && post.profileType == type)
        .toList();

    return posts;
  }
}
