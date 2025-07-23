import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  final AuthRepository<UserModel> authRepository;

  RegisterCubit({required this.authRepository}) : super(RegisterInitialState());

  void register(String firstName, String lastName, DateTime dateOfBirth,
      String email, String password) async {
    emit(RegisterLoadingState());

    try {
      final user = await authRepository.register(
          firstName, lastName, dateOfBirth, email, password);

      emit(RegisterSuccessState('Registration successful', user));
    } catch (e) {
      debugPrint(e.toString());
      emit(RegisterErrorState('Registration failed'));
    }
  }
}
