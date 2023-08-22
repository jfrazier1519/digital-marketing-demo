abstract class Profile {
  final String? profileName;
  final String? profileImage;
  final ProfileType type;
  final String uid;

  Profile({
    this.profileName,
    this.profileImage,
    required this.type,
    required this.uid,
  });
}

enum ProfileType {
  UserProfile,
}
