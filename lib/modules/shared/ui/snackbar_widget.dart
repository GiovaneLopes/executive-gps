import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

enum SnackbarWidgetType {
  error,
  warning,
  success;

  Color color() {
    switch (this) {
      case SnackbarWidgetType.error:
        return Colors.red;
      case SnackbarWidgetType.warning:
        return AppColors.black;
      case SnackbarWidgetType.success:
        return Colors.green;
    }
  }
}

class SnackbarWidget {
  static void mostrar(
    BuildContext context, {
    String? title,
    String? message,
    SnackbarWidgetType? type = SnackbarWidgetType.error,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16.w),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title ?? 'Erro',
                      textAlign: TextAlign.start,
                      style: Styles.body.copyWith(
                        color: type == SnackbarWidgetType.error
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        ScaffoldMessenger.of(context).hideCurrentSnackBar,
                    icon: Icon(
                      Icons.close,
                      color: type == SnackbarWidgetType.error
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                ],
              ),
              Text(
                message ?? 'Tente novamente em instantes.',
                style: Styles.bodySmall.copyWith(
                  color: type == SnackbarWidgetType.error
                      ? AppColors.white
                      : AppColors.black,
                ),
              ),
            ],
          ),
          backgroundColor: type?.color(),
          duration: const Duration(seconds: 8),
        ),
      );
  }
}
