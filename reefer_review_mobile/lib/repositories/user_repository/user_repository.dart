import '../../data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<User> getUserById(String userId);
  Future<void> updateUser(User user);
  Future<void> followBrand(String userId, int brandId);
  Future<void> unfollowBrand(String userId, int brandId);
}
