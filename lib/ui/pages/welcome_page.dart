import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit_state.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginCubitState>(
      builder: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          final userName = state.user.name;

          return Scaffold(
            appBar: AppBar(
              title: Text(userName),
            ),
            body: Center(
              child: Text(
                'Ciao, $userName!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        }

        // Stato di fallback
        return const Scaffold(
          body: Center(
            child: Text('Utente non autenticato'),
          ),
        );
      },
    );
  }
}
