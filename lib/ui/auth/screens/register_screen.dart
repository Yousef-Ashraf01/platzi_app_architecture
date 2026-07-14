import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_api_architecture/routing/app_routes.dart';
import 'package:platzi_api_architecture/ui/auth/cubit/register_cubit.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/register_form.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(child: const _FormArea()),
  );
}

class _FormArea extends StatelessWidget {
  const _FormArea();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
    child: BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully!')),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: const RegisterForm(),
    ),
  );
}
