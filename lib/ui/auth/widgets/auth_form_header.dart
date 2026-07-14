import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/auth/widgets/brand_logo.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_text_styles.dart';

class AuthFormHeader extends StatelessWidget {
  const AuthFormHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const BrandLogo(),
      const SizedBox(height: 18),
      Text(title, textAlign: TextAlign.center, style: AppTextStyles.display),
      const SizedBox(height: 4),
      Text(subtitle, textAlign: TextAlign.center, style: AppTextStyles.body),
    ],
  );
}
