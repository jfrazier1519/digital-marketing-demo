import 'package:reefer_review_mobile/data/models/account.dart';
import 'package:reefer_review_mobile/data/models/product_experience.dart';
import 'package:reefer_review_mobile/data/models/product_preference.dart';
import 'package:reefer_review_mobile/data/models/requests/get_account_request.dart';
import 'package:reefer_review_mobile/data/models/requests/register_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/data/models/requests/update_profile_request.dart';
import 'package:reefer_review_mobile/repositories/account_repository/account_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

class FakeAccountRepository extends AccountRepository {
  static AccountRepository repository = FakeAccountRepository();

  Account? _account;

  final _preferences = [
    ProductPreference('Flower', false),
    ProductPreference('Wax', false),
    ProductPreference('Tincure', false),
    ProductPreference('Distilate', false),
    ProductPreference('Dab', false),
    ProductPreference('Pre-rolls', false),
    ProductPreference('Pre-roll', false),
    ProductPreference('CBD', false),
  ];

  final _productExperiences = [
    ProductExperience('Flower', 0),
    ProductExperience('Wax', 0),
    ProductExperience('Tincure', 0),
    ProductExperience('Distilate', 0),
    ProductExperience('Dab', 0),
    ProductExperience('Pre-rolls', 0),
    ProductExperience('Pre-roll', 0),
    ProductExperience('CBD', 0),
  ];

  @override
  Future<void> registerUser(RegisterUserRequest request) async {}

  @override
  Future<void> sendEmailVerificationLink(
      SendEmailVerifcationLinkRequest request) async {}

  @override
  Future<void> updateProfile(UpdateProfileRequest request) async {
    if (_account != null) {
      if (request.displayName != null) {
        _account!.displayName = request.displayName!;
      }
      if (request.photoUrl != null) {
        _account!.photoUrl = request.photoUrl!;
      }
      if (request.preference != null) {
        _updatePreferences(request.preference!);
      }
      if (request.experience != null) {
        _updateExperience(request.experience!);
      }
    }
  }

  @override
  Account? get currentAccount => _account;

  _updatePreferences(ProductPreference preference) {
    final pref =
        _preferences.firstWhere((element) => element.name == preference.name);
    pref.hasLiked = !preference.hasLiked;
  }

  _updateExperience(ProductExperience experience) {
    var exp = _productExperiences
        .firstWhere((element) => element.name == experience.name);
    exp.rating = experience.rating;
  }

  @override
  Future<void> getAccount(GetAccountRequest? request) async {
    if (request != null) {
      _account = _generateAccount(request.uid);
    }
  }

  Account _generateAccount(String uid) {
    switch (uid) {
      case '1':
        return Account(
          productPreferences: _preferences,
          productExperiences: _productExperiences,
        );
      default:
        return Account(
          productPreferences: _preferences,
          productExperiences: _productExperiences,
          displayName: 'Test',
          photoUrl: dummyProfileImage,
        );
    }
  }
}
