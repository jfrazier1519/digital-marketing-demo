import 'package:reefer_review_mobile/data/user.dart';

abstract class AuthRepository {
  User? get user;

  Future<void> login(String email, String passsword);
}
