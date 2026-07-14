import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    super.key,
    required this.imageBytes,
    required this.onTap,
  });

  final Uint8List? imageBytes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Center(
    child: Semantics(
      button: true,
      label: 'Select profile image',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(52),
        child: Ink(
          width: 104,
          height: 104,
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1.5),
            image: imageBytes == null
                ? null
                : DecorationImage(
                    image: MemoryImage(imageBytes!),
                    fit: BoxFit.cover,
                  ),
          ),
          child: imageBytes == null
              ? const Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.primary,
                  size: 31,
                )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 17,
                      color: AppColors.white,
                    ),
                  ),
                ),
        ),
      ),
    ),
  );
}
