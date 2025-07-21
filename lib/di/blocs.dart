part of 'dependency_injector.dart';

final List<BlocProvider> blocs = [
  BlocProvider<LoginCubit>(
    create: (context) => LoginCubit(
      authRepository: context.read<AuthRepository<UserModel>>(),
    ),
  ),
];
