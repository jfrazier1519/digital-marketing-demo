import 'package:reefer_review_mobile/data/models/requests/register_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/repositories/account_repository/account_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../../data/models/user.dart';

class FakeAccountRepository extends AccountRepository {
  User? _user;

  static final FakeAccountRepository accountRepository =
      FakeAccountRepository._internal();

  FakeAccountRepository._internal() {
    _user = User(
        userId: "someUserId",
        email: "test@mail.com",
        name: "Test User",
        profileImageUrl: dummyProfileImage,
        followedBrands: []);
  }

  User? get user => _user;

  @override
  Future<void> registerUser(RegisterUserRequest request) async {}

  @override
  Future<void> sendEmailVerificationLink(
      SendEmailVerifcationLinkRequest request) async {}

  @override
  Future<User?> getUserById(String userId) async {
    if (_user != null && _user!.userId == userId) {
      return _user;
    }
    return null;
  }
}
