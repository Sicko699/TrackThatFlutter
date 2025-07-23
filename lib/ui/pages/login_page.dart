import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/routers/app_router.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/auth_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit_state.dart';
import 'package:track_that_flutter/theme/ColorPalette.dart';
import 'package:track_that_flutter/theme/Dimensions.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginTap() {
    context.read<LoginCubit>().login(
          _emailController.text,
          _passwordController.text,
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: ColorPalette.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: BlocConsumer<LoginCubit, LoginCubitState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              context.read<AuthCubit>().checkAuthStatus();
              context.router.push(const WelcomeRoute());
            } else if (state is LoginErrorState) {
              // Show an error message if login fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            final (
              isLoading,
              isSuccess,
              UserModel? user,
              errorMessage,
            ) = switch (state) {
              LoginLoadingState() => (true, false, null, null),
              LoginSuccessState(:String message, :UserModel user) => (
                  false,
                  true,
                  user,
                  null
                ),
              LoginErrorState(:String error) => (false, false, null, error),
              _ => (false, false, null, null),
            };

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onLoginTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.router.push(const RegisterRoute());
                  },
                  child: const Text('Non hai un account? Registrati'),
                ),
                if (isLoading) ...[
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ] else if (isSuccess) ...[
                  const SizedBox(height: 20),
                  Text('Welcome, ${user?.name}!'),
                ] else if (errorMessage != null) ...[
                  const SizedBox(height: 20),
                  Text(errorMessage, style: TextStyle(color: Colors.red)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
