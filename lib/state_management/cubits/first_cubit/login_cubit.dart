import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final AuthRepository<UserModel> authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());

    try {
      final user = await authRepository.login(email, password);
      emit(LoginSuccessState('Login successful', user));
    } catch (e) {
      emit(LoginErrorState('Login failed'));
    }
  }

  void updateUser(UserModel user) {
    emit(LoginSuccessState('User updated successfully', user));
  }
}
