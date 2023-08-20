import 'package:reefer_review_mobile/repositories/user_repository/user_repository.dart';
import '../../data/models/user.dart';

class FakeUserRepository extends UserRepository {
  List<User> _users = [];

  static final FakeUserRepository userRepository =
      FakeUserRepository._internal();

  FakeUserRepository._internal();

  @override
  Future<User> getUserById(String userId) async {
    return _users.firstWhere((user) => user.userId == userId);
  }

  @override
  Future<void> updateUser(User updatedUser) async {
    int index = _users.indexWhere((user) => user.userId == updatedUser.userId);
    if (index != -1) {
      _users[index] = updatedUser;
    } else {
      _users.add(updatedUser); // Adds the user to the list if not found.
    }
  }

  @override
  Future<void> followBrand(String userId, int brandId) async {
    User user = await getUserById(userId);
    if (!user.followedBrands.contains(brandId)) {
      user.followedBrands.add(brandId);
      await updateUser(user);
    }
  }

  @override
  Future<void> unfollowBrand(String userId, int brandId) async {
    User user = await getUserById(userId);
    user.followedBrands.remove(brandId);
    await updateUser(user);
  }

  @override
  Future<List<User>> getAllUsers() async {
    return _users;
  }
}
