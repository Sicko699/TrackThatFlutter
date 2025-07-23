import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_that_flutter/mappers/UserMapper.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';
import 'package:track_that_flutter/network/service/authService.dart';
import 'package:flutter/services.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      await prefs.setString('user_firstName', userModel.firstName);
      await prefs.setString('user_lastName', userModel.lastName);
      await prefs.setString('user_email', userModel.email);
      await prefs.setString(
          'user_dob', userModel.dateOfBirth.toIso8601String());
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
      await prefs.remove('user_firstName');
      await prefs.remove('user_lastName');
      await prefs.remove('user_email');
      await prefs.remove('user_dob');
    } on MissingPluginException {
      // Ignore if persistence is unavailable
    }
}

  @override
  Future<UserModel> register(
      String firstName,
      String lastName,
      DateTime dateOfBirth,
      String email,
      String password) async {
    final data = await authService.register(
        firstName, lastName, dateOfBirth, email, password);
    print("Risposta ricevuta dalla register: $data");

    if (data == null ||
        data['uid'] == null ||
        data['email'] == null ||
        data['firstName'] == null ||
        data['lastName'] == null ||
        data['dateOfBirth'] == null) {
      throw Exception("Registration failed or incomplete data");
    }
    print("Dati ricevuti dalla register: $data");

    final userModel = userMapper.fromDTO(UserDTO(
      id: data['uid'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      email: data['email'],
    ));
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userModel.id);
      await prefs.setString('user_firstName', userModel.firstName);
      await prefs.setString('user_lastName', userModel.lastName);
      await prefs.setString('user_email', userModel.email);
      await prefs.setString(
          'user_dob', userModel.dateOfBirth.toIso8601String());
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
      final firstName = prefs.getString('user_firstName');
      final lastName = prefs.getString('user_lastName');
      final email = prefs.getString('user_email');
      final dobString = prefs.getString('user_dob');
      if (id != null && firstName != null && lastName != null && email != null && dobString != null) {
        return UserModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: DateTime.parse(dobString),
            email: email);
      }
    } on MissingPluginException {
      // If the plugin is unavailable, treat as no persisted user
    }
    return null;
  }
}
