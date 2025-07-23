import 'package:track_that_flutter/model/baseModel.dart';
import 'package:track_that_flutter/repositories/base_repository.dart';

abstract class AuthRepository<T> extends BaseRepository<BaseModel> {
  Future<T> login(String email, String password);
  Future<void> logout();
  Future<T> register(
    String firstName,
    String lastName,
    DateTime dateOfBirth,
    String email,
    String password,
  );
  Future<T?> getCurrentUser();
}
