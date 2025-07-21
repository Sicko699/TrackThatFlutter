part of 'dependency_injector.dart';

final List<RepositoryProvider> repositories = [
  RepositoryProvider<AuthRepository<UserModel>>(
    create: (context) => AuthRepositoryImpl(
      authService: context.read<Authservice>(),
      userMapper: context.read<Usermapper>(),
    ),
  ),
];
