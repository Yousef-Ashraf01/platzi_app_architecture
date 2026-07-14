import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_api_architecture/data/models/register_body.dart';
import 'package:platzi_api_architecture/ui/auth/cubit/register_cubit.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_form_header.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_labeled_field.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_navigation_prompt.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_password_field.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/profile_image_picker.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';
import 'package:platzi_api_architecture/ui/core/validators/app_validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _imagePicker = ImagePicker();
  bool _obscurePassword = true;
  Uint8List? _avatarBytes;
  String? _avatarFileName;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_avatarBytes == null || _avatarFileName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a profile image')),
        );
        return;
      }
      context.read<RegisterCubit>().register(
        registerBody: RegisterBody(
          name: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          avatar: '',
        ),
        imageBytes: _avatarBytes!,
        imageName: _avatarFileName!,
      );
    }
  }

  Future<void> _pickProfileImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null) return;

    final imageBytes = await image.readAsBytes();
    if (!mounted) return;
    setState(() {
      _avatarBytes = imageBytes;
      _avatarFileName = image.name;
    });
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthFormHeader(
          title: 'Create Account',
          subtitle:
              'Join the Shop community and\ndiscover premium styles today.',
        ),
        const SizedBox(height: 33),
        ProfileImagePicker(imageBytes: _avatarBytes, onTap: _pickProfileImage),
        const SizedBox(height: 10),
        const Text(
          'Add profile image',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.body),
        ),
        const SizedBox(height: 24),
        AuthLabeledField(
          label: 'Full Name',
          hint: 'John Doe',
          prefixIcon: Icons.person_outline_rounded,
          controller: _fullNameController,
          keyboardType: TextInputType.name,
          validator: AppValidators.fullName,
        ),
        const SizedBox(height: 18),
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
        const SizedBox(height: 18),
        AuthPasswordField(
          label: 'Confirm Password',
          controller: _confirmPasswordController,
          prefixIcon: Icons.lock_clock_outlined,
          isObscured: _obscurePassword,
          onVisibilityChanged: (value) =>
              setState(() => _obscurePassword = value),
          validator: (value) =>
              AppValidators.confirmPassword(value, _passwordController.text),
        ),
        const SizedBox(height: 22),
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) => ElevatedButton(
            onPressed: state is RegisterLoading ? null : _register,
            child: state is RegisterLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Text('Create Account'),
          ),
        ),
        const SizedBox(height: 33),
        AuthNavigationPrompt(
          message: 'Already have an account? ',
          actionLabel: 'Login',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
