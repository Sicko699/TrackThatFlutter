import 'package:flutter/material.dart';
import 'package:track_that_flutter/di/dependency_injector.dart';
import 'package:track_that_flutter/network/firebase_config.dart';
import 'package:track_that_flutter/routers/app_router.dart';
import 'package:track_that_flutter/theme/AppTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
           child: MaterialApp.router(
      title: 'Track That Flutter',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.config(),
    ));
  }
}

