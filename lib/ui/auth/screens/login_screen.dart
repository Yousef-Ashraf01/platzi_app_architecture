import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_api_architecture/routing/app_routes.dart';
import 'package:platzi_api_architecture/ui/auth/cubit/login_cubit.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/login_form.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
    child: BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      child: LoginForm(),
    ),
  );
}
