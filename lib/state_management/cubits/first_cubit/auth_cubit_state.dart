import 'package:track_that_flutter/model/entities/user.dart';

class AuthCubitState {}

class AuthInitialState extends AuthCubitState {}

class AuthLoadingState extends AuthCubitState {}

class AuthAuthenticatedState extends AuthCubitState {
  final UserModel user;
  AuthAuthenticatedState(this.user);
}

class AuthUnauthenticatedState extends AuthCubitState {}
