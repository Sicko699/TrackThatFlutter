import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/firebase_service.dart';
import 'package:track_that_flutter/network/service/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      id: userData['uid'],
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      dateOfBirth: (userData['dateOfBirth'] as Timestamp).toDate(),
    );

    return userDto;
  }

  @override
  Future<void> logout() async {
    await _firebaseService.signOut();
  }

  @override
  Future<Map<String, dynamic>> register(
      String firstName,
      String lastName,
      DateTime dateOfBirth,
      String email,
      String password) {
    return _firebaseService
        .registerUser(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            email: email,
            password: password)
        .then((userData) {
      if (userData == null) {
        throw Exception('Registration failed');
      }
      return userData;
    });
  }

  @override
  Future<Map<String, dynamic>?> getCurrentUser() async {
    return _firebaseService.getCurrentUserData();
  }
}
