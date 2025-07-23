class UserDTO {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;

  UserDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
  });
}