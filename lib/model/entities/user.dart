import 'package:track_that_flutter/model/baseModel.dart';

class UserModel implements BaseModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
}
