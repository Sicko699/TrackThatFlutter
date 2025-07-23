
import 'package:track_that_flutter/model/entities/user.dart';

class RegisterCubitState {}

class RegisterInitialState extends RegisterCubitState {}

class RegisterLoadingState extends RegisterCubitState {}

class RegisterSuccessState extends RegisterCubitState {
  final String message;
  final UserModel user;
  RegisterSuccessState(this.message, this.user);
}

class RegisterErrorState extends RegisterCubitState {
  final String error;
  RegisterErrorState(this.error);
}