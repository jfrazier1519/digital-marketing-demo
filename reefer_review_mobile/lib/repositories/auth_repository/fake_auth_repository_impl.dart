import 'package:reefer_review_mobile/data/user.dart';
import 'package:reefer_review_mobile/repositories/auth_repository/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  User? _user;

  @override
  Future<void> login(String email, String passsword) async {
    _user = User("test@mail.com");
  }

  @override
  User? get user => _user;
}
