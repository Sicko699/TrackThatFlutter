import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/firebase_service.dart';
import 'package:track_that_flutter/network/service/base_service.dart';

abstract class Authservice extends BaseService {
  Future<UserDTO> login(String email, String password);
  Future<void> logout();

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final firebaseService = FirebaseService();
    final userData = await firebaseService.registerUser(
      name: name,
      email: email,
      password: password,
    );
    if (userData == null) {
      throw Exception('Registration failed');
    }
    return userData;
  }
  
  Future<Map<String, dynamic>?> getCurrentUser();
}
