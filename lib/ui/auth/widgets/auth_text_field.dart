import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_dimensions.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
  });

  final String hint;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: AppDimensions.fieldHeight,
    child: TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.ink, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon, color: AppColors.icon, size: 23),
        suffixIcon: suffixIcon,
      ),
    ),
  );
}
