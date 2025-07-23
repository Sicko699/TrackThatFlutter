import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:track_that_flutter/routers/auth_guard.dart';

import 'package:track_that_flutter/ui/pages/home_page.dart';
import 'package:track_that_flutter/ui/pages/login_page.dart';
import 'package:track_that_flutter/ui/pages/register_page.dart';
import 'package:track_that_flutter/ui/pages/welcome_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page, initial: true),
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: '/welcome',
          page: WelcomeRoute.page,
        ),
        AutoRoute(
          path: '/register',
          page: RegisterRoute.page,
        ),
      ];
}
