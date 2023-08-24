import 'package:reefer_review_mobile/data/models/user/user.dart';
import 'package:reefer_review_mobile/data/models/product/product_experience.dart';
import 'package:reefer_review_mobile/data/models/product/product_preference.dart';
import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/register_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/data/models/requests/update_profile_request.dart';
import 'package:reefer_review_mobile/repositories/user_repository/user_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../utilities/custom_entity_exception.dart';

class FakeUserRepository extends UserRepository {
  static UserRepository repository = FakeUserRepository._internal();

  FakeUserRepository._internal();

  User? _account;

  final List<User> _users = [
    User(
      uid: '1',
      email: 'JackedupJill@gmail.com',
      displayName: 'Jack',
      photoUrl: userID1,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '2',
      email: 'MsTibbs@yahoo.com',
      displayName: 'MsTibbs',
      photoUrl: userID2,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '3',
      email: 'SombodyCallDaDoctor@gmail.com',
      displayName: 'DrDankenstein',
      photoUrl: userID3,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '4',
      email: 'FreshireCat1257@hotmail.com',
      displayName: 'FranDaMan',
      photoUrl: userID4,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '5',
      email: 'MaryJane420@gmail.com',
      displayName: 'MissJane',
      photoUrl: userID5,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '6',
      email: 'SmokeHunter@gmail.com',
      displayName: 'Artemis420',
      photoUrl: userID6,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '7',
      email: 'Wafflelover@hotmail.com',
      displayName: 'LeggoDaEggo',
      photoUrl: userID7,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '8',
      email: 'HemanAintDiddly@greyskull.com',
      displayName: 'Sheera',
      photoUrl: userID8,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '9',
      email: 'Plantsaregreat@gmail.com',
      displayName: 'HordaCULTure',
      photoUrl: userID9,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '10',
      email: 'BigBrainPlayer@yahoo.com',
      displayName: 'BossToss',
      photoUrl: userID10,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '11',
      email: 'KushGrandma@gmail.com',
      displayName: 'KushG-ma',
      photoUrl: userID11,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
    User(
      uid: '12',
      email: 'SNinja664@gmail.com',
      displayName: 'SmokeNinja',
      photoUrl: userID12,
      productExperiences: [],
      productPreferences: [],
      followedBrands: [],
      followedUsers: [],
      followedVenues: [],
    ),
  ];

  final _preferences = [
    ProductPreference('Flower', false),
    ProductPreference('Wax', false),
    ProductPreference('Tincture', false),
    ProductPreference('Distillate', false),
    ProductPreference('Dab', false),
    ProductPreference('Pre-rolls', false),
    ProductPreference('Pre-roll (Infused)', false),
    ProductPreference('CBD', false),
  ];

  final _productExperiences = [
    ProductExperience('Flower', 0),
    ProductExperience('Wax', 0),
    ProductExperience('Tincture', 0),
    ProductExperience('Distillate', 0),
    ProductExperience('Dab', 0),
    ProductExperience('Pre-rolls', 0),
    ProductExperience('Pre-roll (Infused)', 0),
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
  User? get currentAccount => _account;

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

  User _generateAccount({bool firstTime = false}) {
    final uid = firstTime ? '1' : '0';
    switch (uid) {
      case '1':
        return User(
          email: 'Test@mail.com',
          uid: '0',
          productPreferences: _preferences,
          productExperiences: _productExperiences,
          followedBrands: [],
          followedUsers: [],
          followedVenues: [],
        );
      default:
        return User(
          uid: '1',
          email: 'JackedupJill@gmail.com',
          productPreferences: _preferences,
          productExperiences: _productExperiences,
          displayName: 'Jack',
          photoUrl: userID1,
          followedBrands: ['1'],
          followedUsers: ['3', '4', '12'],
          followedVenues: ['1', '2', '3'],
        );
    }
  }

  @override
  Future<void> logout() async {
    _account = null;
  }

  @override
  Future<void> login(LoginUserRequest request) async {
    if (request.password == '1234') {
      _account = _generateAccount(firstTime: true);
    } else {
      _account = _generateAccount();
    }
  }

  @override
  Future<User> getUserById(String uid) async {
    try {
      return _users.firstWhere((user) => user.uid == uid);
    } catch (_) {
      throw EntityNotFoundException('User with id $uid not found');
    }
  }

  @override
  Future<void> updateUser(User updatedUser) async {
    int index = _users.indexWhere((user) => user.uid == updatedUser.uid);
    if (index != -1) {
      _users[index] = updatedUser;
    } else {
      _users.add(updatedUser);
    }
  }

  @override
  Future<void> followBrand(User user, String brandId) async {
    if (!user.followedBrands.contains(brandId)) {
      user.followedBrands.add(brandId);
      await updateUser(user);
    }
  }

  @override
  Future<void> unfollowBrand(User user, String brandId) async {
    user.followedBrands.remove(brandId);
    await updateUser(user);
  }

  @override
  Future<List<User>> getAllUsers() async {
    return _users;
  }
}
