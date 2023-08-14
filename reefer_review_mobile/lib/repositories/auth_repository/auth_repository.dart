import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/data/models/user.dart';

abstract class AuthRepository {
  User? get user;

  Future<void> login(LoginUserRequest request);

  Future<void> logout();
}
