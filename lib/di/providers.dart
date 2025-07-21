part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<FirebaseService>(
    create: (context) => FirebaseService(),
  ),
  Provider<Authservice>(
    create: (context) => AuthserviceImpl(
      firebaseService: context.read<FirebaseService>(),
    ),
  ),
];
