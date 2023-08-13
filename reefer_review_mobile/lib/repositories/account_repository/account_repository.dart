import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';

import '../../data/models/requests/register_user_request.dart';

abstract class AccountRepository {
  Future<void> registerUser(RegisterUserRequest request);
  Future<void> sendEmailVerificationLink(
      SendEmailVerifcationLinkRequest request);
}
