class RegisterUserRequest {
  final String email;
  final String password;
  final String state;
  final DateTime? dob;
  final String? id;
  final String? firstName;
  final String? lastName;

  RegisterUserRequest({
    required this.email,
    required this.password,
    required this.state,
    required this.dob,
    required this.id,
    required this.firstName,
    required this.lastName,
  });
}
