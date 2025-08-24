import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Color textColor;
  final Color borderColor;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int maxLines;
  final bool obscureText;
  final bool loading;
  final bool enabled;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.white,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.loading = false,
    this.enabled = true,
    this.controller,
    this.onEditingComplete,
    this.onChanged,
  });

  // Named 'light' constructor for a variant with light styling
  const CustomTextFormField.light({
    super.key,
    this.labelText,
    this.hintText,
    this.textColor = AppColors.black,
    this.borderColor = AppColors.grey,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.loading = false,
    this.enabled = true,
    this.controller,
    this.onEditingComplete,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: AppColors.primary,
      validator: validator,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines,
      style: Styles.bodyLight.copyWith(
        color: textColor,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: Styles.bodyLight.copyWith(color: borderColor),
        labelStyle: Styles.bodyLight,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.white,
              )
            : null,
        suffixIcon: loading
            ? Container(
                padding: EdgeInsets.all(12.w),
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.white,
                ),
              )
            : suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor,
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
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
