import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_labeled_field.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';

class AuthPasswordField extends StatelessWidget {
  const AuthPasswordField({
    super.key,
    required this.label,
    required this.controller,
    required this.isObscured,
    required this.onVisibilityChanged,
    required this.validator,
    this.prefixIcon = Icons.lock_outline_rounded,
  });

  final String label;
  final TextEditingController controller;
  final bool isObscured;
  final ValueChanged<bool> onVisibilityChanged;
  final String? Function(String?)? validator;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) => AuthLabeledField(
    label: label,
    hint: 'Password',
    prefixIcon: prefixIcon,
    controller: controller,
    obscureText: isObscured,
    validator: validator,
    suffixIcon: IconButton(
      tooltip: isObscured ? 'Show password' : 'Hide password',
      onPressed: () => onVisibilityChanged(!isObscured),
      icon: Icon(
        isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppColors.icon,
      ),
    ),
  );
}
