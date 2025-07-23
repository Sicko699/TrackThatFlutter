import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/firebase_service.dart';
import 'package:track_that_flutter/network/service/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AuthserviceImpl implements Authservice {
  final FirebaseService _firebaseService;
  AuthserviceImpl({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  @override
  Future<UserDTO> login(String email, String password) async {
    // Fetch user information along with authentication
    Map<String, dynamic>? userData = await _firebaseService
        .loginAndFetchUserData(email: email, password: password);

    if (userData == null) {
      // Bubble up a clear exception if no data is returned
      throw Exception('Login failed');
    }

    // Support legacy field names that might differ from the ones
    // used when creating new users via [registerUser].
    final firstName =
        userData['firstName'] ?? userData['nome'] ?? userData['Name'];
    final lastName =
        userData['lastName'] ?? userData['cognome'] ?? userData['Surname'];
    final rawDob =
        userData['dateOfBirth'] ?? userData['dataDiNascita'] ?? userData['dob'];

    DateTime dateOfBirth;
    if (rawDob is Timestamp) {
      dateOfBirth = rawDob.toDate();
    } else if (rawDob is String) {
      // Handle both ISO-8601 and dd/MM/yyyy formats.
      dateOfBirth = DateTime.tryParse(rawDob) ??
          DateFormat('dd/MM/yyyy').parse(rawDob);
    } else if (rawDob is DateTime) {
      dateOfBirth = rawDob;
    } else {
      throw Exception('Invalid date of birth');
    }

    final id = userData['uid'] ?? userData['id'];

    return UserDTO(
      email: userData['email'] ?? email,
      id: id,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );
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
