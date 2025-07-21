import 'package:track_that_flutter/model/entities/user.dart';

class LoginCubitState {}

class LoginInitialState extends LoginCubitState {}

class LoginLoadingState extends LoginCubitState {}

class LoginSuccessState extends LoginCubitState {
  final String message;
  final UserModel user;

  LoginSuccessState(this.message, this.user);
}

class LoginErrorState extends LoginCubitState {
  final String error;

  LoginErrorState(this.error);
}
