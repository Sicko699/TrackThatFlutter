import 'package:track_that_flutter/model/baseModel.dart';

class UserModel implements BaseModel {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
  });
}
