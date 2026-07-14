import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_text_styles.dart';

class AuthNavigationPrompt extends StatelessWidget {
  const AuthNavigationPrompt({
    super.key,
    required this.message,
    required this.actionLabel,
    required this.onPressed,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(message, style: AppTextStyles.body),
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          actionLabel,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}
