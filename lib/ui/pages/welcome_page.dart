import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/state_management/cubits/auth/auth_cubit.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(user.name),
            ),
            body: Center(
              child: Text(
                'Ciao, ${user.name}!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Utente non autenticato'),
            ),
          );
        }
      },
    );
  }
}
