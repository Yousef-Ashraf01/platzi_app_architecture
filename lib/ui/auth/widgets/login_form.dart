import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:platzi_api_architecture/routing/app_routes.dart';
import 'package:platzi_api_architecture/ui/auth/cubit/login_cubit.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_form_header.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_labeled_field.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_navigation_prompt.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_password_field.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';
import 'package:platzi_api_architecture/ui/core/validators/app_validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthFormHeader(
          title: 'Welcome back',
          subtitle: 'Log in to your Shop account',
        ),
        const SizedBox(height: 33),
        AuthLabeledField(
          label: 'Email Address',
          hint: 'name@example.com',
          prefixIcon: Icons.mail_outline_rounded,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: AppValidators.email,
        ),
        const SizedBox(height: 18),
        AuthPasswordField(
          label: 'Password',
          controller: _passwordController,
          isObscured: _obscurePassword,
          onVisibilityChanged: (value) =>
              setState(() => _obscurePassword = value),
          validator: AppValidators.password,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 14),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final isLoading = state is LoginLoading;
            return ElevatedButton(
              onPressed: isLoading ? null : _login,
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Login'),
                        const SizedBox(width: 7),
                        const Icon(Icons.arrow_forward_rounded, size: 22),
                      ],
                    ),
            );
          },
        ),
        const SizedBox(height: 33),
        AuthNavigationPrompt(
          message: "Don't have an account? ",
          actionLabel: 'Register',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
        ),
      ],
    ),
  );
}
