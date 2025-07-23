import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/routers/app_router.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/auth_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/register_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/register_cubit_state.dart';
import 'package:track_that_flutter/theme/ColorPalette.dart';
import 'package:track_that_flutter/theme/Dimensions.dart';
import 'package:track_that_flutter/ui/widgets/date_picker_field.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  DateTime? _birthDate;

  void _onRegisterTap() {
    if (_passwordController.text != _confirmPasswordController.text ||
        _birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Controlla i dati inseriti')),
      );
      return;
    }
    context.read<RegisterCubit>().register(
          _firstNameController.text,
          _lastNameController.text,
          _birthDate!,
          _emailController.text,
          _passwordController.text,
        );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: ColorPalette.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: BlocConsumer<RegisterCubit, RegisterCubitState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              context.read<AuthCubit>().checkAuthStatus();
              context.router.push(const WelcomeRoute());
              context.read<LoginCubit>().updateUser(state.user);
            } else if (state is RegisterErrorState) {
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
              RegisterLoadingState() => (true, false, null, null),
              RegisterSuccessState(:String message, :UserModel user) => (
                  false,
                  true,
                  user,
                  null
                ),
              RegisterErrorState(:String error) => (false, false, null, error),
              _ => (false, false, null, null),
            };

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Cognome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                DatePickerField(
                  label: 'Data di nascita',
                  onDateSelected: (d) => _birthDate = d,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Conferma Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onRegisterTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Register'),
                  ),
                ),
                if (isLoading) ...[
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ] else if (isSuccess) ...[
                  const SizedBox(height: 20),
                  Text('Welcome, ${user?.firstName}!'),
                ] else if (errorMessage != null) ...[
                  const SizedBox(height: 20),
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}