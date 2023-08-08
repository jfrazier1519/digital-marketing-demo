import 'package:reefer_review_mobile/data/user.dart';
import 'package:reefer_review_mobile/repositories/auth_repository/auth_repository.dart';
import '../../res/images.dart';

class FakeAuthRepository implements AuthRepository {
  User? _user;

  @override
  Future<void> login(String email, String password) async {
    _user = User(
        userId: "someUserId",
        email: "test@mail.com",
        name: "Test User",
        profileImageUrl: dummyProfileImage);
  }

  @override
  Future<void> logout() async {
    _user = null;
  }

  @override
  User? get user => _user;
}
