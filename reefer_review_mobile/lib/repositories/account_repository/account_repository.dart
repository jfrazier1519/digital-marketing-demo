import 'package:reefer_review_mobile/data/models/requests/get_account_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/data/models/requests/update_profile_request.dart';

import '../../data/models/account.dart';
import '../../data/models/requests/register_user_request.dart';

abstract class AccountRepository {
  Account? get currentAccount;

  Future<void> registerUser(RegisterUserRequest request);
  Future<void> sendEmailVerificationLink(
      SendEmailVerifcationLinkRequest request);
  Future<void> updateProfile(UpdateProfileRequest request);
  Future<void> getAccount(GetAccountRequest? request);
}
