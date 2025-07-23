import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/firebase_service.dart';
import 'package:track_that_flutter/network/service/authService.dart';

class AuthserviceImpl implements Authservice {
  final FirebaseService _firebaseService;
  AuthserviceImpl({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  @override
  Future<UserDTO> login(String email, String password) async {
    Map<String, dynamic>? userData = await _firebaseService
        .loginAndFetchUserData(email: email, password: password);

    if (userData == null) {
      throw Exception("Login failed");
    }

    UserDTO userDto = UserDTO(
      email: email,
      id: userData['id'],
      name: userData['nome'],
    );

    return userDto;
  }

  @override
  Future<void> logout() {
    // Implement logout logic here
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> register(
      String name, String email, String password) {
      return _firebaseService
          .registerUser(name: name, email: email, password: password)
          .then((userData) {
        if (userData == null) {
          throw Exception('Registration failed');
        }
        return userData;
      });
  }

  @override
  Future<Map<String, dynamic>?> getCurrentUser() {
    // Implement logic to get current user here
    throw UnimplementedError();
  }
}
