import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepository<UserModel> authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitialState());

  Future<void> checkAuthStatus() async {
    emit(AuthLoadingState());
    try {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticatedState(user));
      } else {
        emit(AuthUnauthenticatedState());
      }
    } catch (_) {
      emit(AuthUnauthenticatedState());
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthUnauthenticatedState());
  }
}
