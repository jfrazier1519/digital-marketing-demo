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
          ProductPost(
              postId: '1',
              authorId: '4',
              date: DateTime.now(),
              content:
                  'Be the first to purchase our new honeycomb rig! It not only works as great as it looks but combines easily with any E-Nail. To make the deal even sweeter we even offer a 30 day money back gaurantee. Dont let this opportunity pass you by!',
              image: productID13_PostID1,
              productUrl: 'product_screen_route',
              productId: '13',
              profileType: ProfileType.BrandProfile),
          ProductPost(
              postId: '2',
              authorId: '3',
              date: DateTime.now(),
              content:
                  'We have great news for all of you CDB fans out there, our Fruit Bear CBD gumies are back in stock! they are a steal at only \$15 a pack. Come in on thursday and when you buy 2 packs you get the third for 1/2 price! Don\'t be a dummy, come get some gummies!',
              image: productID9_PostID2,
              productUrl: 'product_screen_route',
              productId: '9',
              profileType: ProfileType.VenueProfile),
          ProductPost(
              postId: '3',
              authorId: '2',
              date: DateTime.now(),
              content:
                  'Great news! We just landed some delicious Durban Poison Infused Pre-rolls and want to let you be the first to know. Come in and check out the delicious and relaxing feel of one of the best strains around.',
              image: productID4_PostID3,
              productUrl: 'product_screen_route',
              productId: '4',
              profileType: ProfileType.VenueProfile),
          EventPost(
            postId: '4',
            authorId: '3',
            date: DateTime.now(),
            content:
                'Come join us for a night of fire spinning and fun! There will be food, live music, and even a secret sponser! Learn to spin fire yourself by signing up for a class online! Check us out at firespinnersunited.org.',
            image: eventID1,
            eventUrl: 'event_screen_route',
            profileType: ProfileType.BrandProfile,
          ),
          EventPost(
            postId: '5',
            authorId: '3',
            date: DateTime.now(),
            content:
                'Ever wonder where we grow our world famous crops? Well this is your chance to come take a look and maybe even learn something new. You can sign up for a tour at our webiste at Greenthumbs.org. We may even have a special suprise for the first 100 people that sign up for a tour.',
            image: eventID2,
            eventUrl: 'event_screen_route',
            profileType: ProfileType.BrandProfile,
          ),
          EventPost(
            postId: '6',
            authorId: '1',
            date: DateTime.now(),
            content:
                'Like music and the jazz cabbage? Well... so do we so come party with us at this years Kickers Ball! 3 day event with stages 6 stages, food trucks, homegrown shops, some of your favorite Cannabis Brands and more. Tickets, camping passes, and parking passes for sale online at KickersBallMF.org.',
            image: eventID3,
            eventUrl: 'event_screen_route',
            profileType: ProfileType.BrandProfile,
          ),
          LoyaltyPost(
              postId: '3',
              authorId: '1',
              date: DateTime.now(),
              content: 'This is a loyalty post.',
              image: dummyLoyaltyPostImage,
              crystals: '5',
              profileType: ProfileType.UserProfile),
          ReviewPost(
              postId: '5',
              authorId: '1',
              date: DateTime.now(),
              content: 'This is a review post.',
              image: dummyReviewPostImage,
              reviewStars: 4.5,
              profileType: ProfileType.UserProfile),
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
