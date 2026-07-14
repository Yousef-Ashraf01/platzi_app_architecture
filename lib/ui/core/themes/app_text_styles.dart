import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';

abstract final class AppTextStyles {
  static const display = TextStyle(
    fontSize: 28,
    height: 1.17,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.7,
    color: AppColors.ink,
  );
  static const title = TextStyle(
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    color: AppColors.ink,
  );
  static const body = TextStyle(
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.body,
  );
  static const label = TextStyle(
    fontSize: 14,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );
  static const button = TextStyle(
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const caption = TextStyle(
    fontSize: 13,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.body,
  );
}
