import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/auth_text_field.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_text_styles.dart';

class AuthLabeledField extends StatelessWidget {
  const AuthLabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.body),
      const SizedBox(height: 7),
      AuthTextField(
        controller: controller,
        hint: hint,
        prefixIcon: prefixIcon,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText,
        suffixIcon: suffixIcon,
      ),
    ],
  );
}
