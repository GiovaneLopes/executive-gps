import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final T? initialValue;
  final List<T>? items;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final ValueChanged<T?> onChanged;
  final bool isDense;
  const CustomDropdownButtonFormField({
    super.key,
    this.initialValue,
    this.items,
    this.dropdownItems,
    required this.onChanged,
    this.isDense = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: initialValue,
      isExpanded: true,
      isDense: isDense,
      validator: (value) => InputValidators.validateEmpty(value?.toString()),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: AppColors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: AppColors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
      items: dropdownItems ??
          items?.map((value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                value.toString(),
                style: Styles.bodySmall,
              ),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
