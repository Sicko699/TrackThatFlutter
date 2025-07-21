import 'package:track_that_flutter/mappers/UserMapper.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/service/authService.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';

class AuthRepositoryImpl implements AuthRepository<UserModel> {
  Authservice authService;
  Usermapper userMapper;

  AuthRepositoryImpl({required this.authService, required this.userMapper});

  @override
  Future<UserModel> login(String email, String password) async {
    UserDTO userDto = await authService.login(email, password);
    if (userDto == null) {
      throw Exception("Login failed");
    }
    UserModel userModel = userMapper.fromDTO(userDto);
    return userModel;
  }

  @override
  Future<void> logout() {
    // Implement logout logic here
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register(String name, String email, String password) {
    // Implement registration logic here
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getCurrentUser() {
    // Implement logic to get current user here
    throw UnimplementedError();
  }
}
