import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/data/models/user.dart';
import 'package:reefer_review_mobile/repositories/auth_repository/auth_repository.dart';
import '../../res/images.dart';

class FakeAuthRepository implements AuthRepository {
  User? _user;

  @override
  Future<void> login(LoginUserRequest request) async {
    if (request.password == '1234') {
      _user = User(
        userId: "1",
        email: "test@mail.com",
        name: null,
        profileImageUrl: dummyProfileImage,
      );
    } else {
      _user = User(
        userId: "someUserId",
        email: "test@mail.com",
        name: "Test User",
        profileImageUrl: dummyProfileImage,
      );
    }
  }

  @override
  Future<void> logout() async {
    _user = null;
  }

  @override
  User? get user => _user;
}
