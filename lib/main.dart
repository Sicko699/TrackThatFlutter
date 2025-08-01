import 'package:flutter/material.dart';
import 'package:track_that_flutter/di/dependency_injector.dart';
import 'package:track_that_flutter/network/firebase_config.dart';
import 'package:track_that_flutter/routers/app_router.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/auth_cubit_state.dart';
import 'package:track_that_flutter/theme/AppTheme.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await FirebaseConfig.init();

  runApp(const TrackThatFlutterApp());
}

class TrackThatFlutterApp extends StatelessWidget {
  const TrackThatFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return DependencyInjector(
      child: BlocListener<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            appRouter.replaceAll([const WelcomeRoute()]);
          } else if (state is AuthUnauthenticatedState) {
            appRouter.replaceAll([const LoginRoute()]);
          }
        },
        child: MaterialApp.router(
          title: 'Track That Flutter',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: appRouter.config(),
        ),
      ),
    );
  }
}

