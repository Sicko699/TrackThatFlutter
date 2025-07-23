import 'package:flutter/material.dart';
import 'package:track_that_flutter/di/dependency_injector.dart';
import 'package:track_that_flutter/network/firebase_config.dart';
import 'package:track_that_flutter/routers/app_router.dart';
import 'package:track_that_flutter/theme/AppTheme.dart';
import 'package:track_that_flutter/state_management/cubits/auth/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseConfig.init();
  runApp(const TrackThatFlutterApp());
}

class TrackThatFlutterApp extends StatefulWidget {
  const TrackThatFlutterApp({super.key});

  @override
  State<TrackThatFlutterApp> createState() => _TrackThatFlutterAppState();
}

class _TrackThatFlutterAppState extends State<TrackThatFlutterApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _router.replaceAll([const WelcomeRoute()]);
          } else if (state is AuthUnauthenticated) {
            _router.replaceAll([const LoginRoute()]);
          }
        },
        child: MaterialApp.router(
          title: 'Track That Flutter',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: _router.config(),
        ),
      ),
    );
  }
}


