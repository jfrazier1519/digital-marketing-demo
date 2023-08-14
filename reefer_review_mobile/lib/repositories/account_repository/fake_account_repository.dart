import 'package:reefer_review_mobile/data/models/requests/register_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/repositories/account_repository/account_repository.dart';

class FakeAccountRepository extends AccountRepository {
  @override
  Future<void> registerUser(RegisterUserRequest request) async {}

  @override
  Future<void> sendEmailVerificationLink(
      SendEmailVerifcationLinkRequest request) async {}
}
