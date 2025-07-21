import 'package:track_that_flutter/model/baseModel.dart';


class User implements BaseModel {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}