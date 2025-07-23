import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_that_flutter/mappers/UserMapper.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/service/authService.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';
import 'package:track_that_flutter/other/contants/AppConstants.dart';

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userIdKey, userModel.id);
    return userModel;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.userIdKey);
    await authService.logout();
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final data = await authService.register(name, email, password);
    print("Risposta ricevuta dalla register: $data");

    if (data == null ||
        data['uid'] == null ||
        data['email'] == null ||
        data['name'] == null) {
      throw Exception("Registration failed or incomplete data");
    }
    print("Dati ricevuti dalla register: $data");

    final user = userMapper.fromDTO(UserDTO(
      id: data['uid'],
      name: data['name'],
      email: data['email'],
    ));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userIdKey, user.id);
    return user;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString(AppConstants.userIdKey);
    if (savedId == null) return null;
    final data = await authService.getCurrentUser();
    if (data == null) return null;
    return userMapper.fromDTO(UserDTO(
      id: data['uid'],
      name: data['name'],
      email: data['email'],
    ));
  }
}
