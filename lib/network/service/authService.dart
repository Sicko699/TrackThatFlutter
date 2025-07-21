import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/service/base_service.dart';

abstract class Authservice extends BaseService {
  Future<UserDTO> login(String email, String password);
  Future<void> logout();
  Future<Map<String, dynamic>> register(
      String name, String email, String password);
  Future<Map<String, dynamic>?> getCurrentUser();
}
