part of 'dependency_injector.dart';

final List<BlocProvider> blocs = [
  BlocProvider<LoginCubit>(
    create: (context) => LoginCubit(
      authRepository: context.read<AuthRepository<UserModel>>(),
    ),
  ),
  BlocProvider<RegisterCubit>(
    create: (context) => RegisterCubit(
      authRepository: context.read<AuthRepository<UserModel>>(),
    ),
  ),
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(
      authRepository: context.read<AuthRepository<UserModel>>(),
    )..checkAuthStatus(),
  ),
];
