import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: ListTile(
        title: Row(
          children: [
            Icon(
              FeatherIcons.mapPin,
              color: AppColors.primary,
              size: 16.w,
            ),
            const SizedBox(width: 8),
            Text(
              'Andressa Oliveira',
              style: Styles.bodySmall.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Text(
            'Rua Felipe Camarão - 117, Tatuapé, São Paulo SP - 03418-090',
            style: Styles.bodySmall.copyWith(color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
