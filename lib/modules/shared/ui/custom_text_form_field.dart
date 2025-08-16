import 'package:flutter/material.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: AppColors.primary,
      validator: validator,
      onEditingComplete: onEditingComplete,
      style: Styles.bodyLight.copyWith(
        color: AppColors.white,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: Styles.bodyLight.copyWith(color: AppColors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.white,
              )
            : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
