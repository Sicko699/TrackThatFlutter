import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
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
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userModel.id);
      await prefs.setString('user_name', userModel.name);
      await prefs.setString('user_email', userModel.email);
    } on MissingPluginException {
      // When running without platform bindings (e.g. tests), ignore persistence
    }
    return userModel;
  }

  @override
  Future<void> logout() async {
    await authService.logout();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
    } on MissingPluginException {
      // Ignore if persistence is unavailable
    }
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

    final userModel = userMapper.fromDTO(UserDTO(
      id: data['uid'],
      name: data['name'],
      email: data['email'],
    ));
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userModel.id);
      await prefs.setString('user_name', userModel.name);
      await prefs.setString('user_email', userModel.email);
    } on MissingPluginException {
      // Persistence unavailable; continue without storing
    }
    return userModel;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('user_id');
      final name = prefs.getString('user_name');
      final email = prefs.getString('user_email');
      if (id != null && name != null && email != null) {
        return UserModel(id: id, name: name, email: email);
      }
    } on MissingPluginException {
      // If the plugin is unavailable, treat as no persisted user
    }
    return null;
  }
}
