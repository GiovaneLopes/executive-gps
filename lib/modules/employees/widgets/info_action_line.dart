import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/employees/widgets/info_line.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class InfoAction extends StatelessWidget {
  final String? label;
  final String value;

  const InfoAction({
    super.key,
    this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoLine(
            label: label,
            value: value,
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('${label ?? 'Dado'} copiado com sucesso!')),
            );
          },
          icon: Row(
            children: [
              Icon(Icons.copy, color: AppColors.primaryDark, size: 16.w),
              SizedBox(width: 4.w),
              Text(
                'Copiar',
                style: Styles.bodySmall.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
