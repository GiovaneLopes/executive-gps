import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 24.w),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      color: Colors.blue.shade100,
                      child: Text(
                        'Em andamento',
                        style: Styles.bodySmall.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '31/09/2025 - 13h00',
                      style: Styles.bodySmall.copyWith(fontSize: 11.sp),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Text(
                      'Cliente:',
                      style: Styles.bodySmall
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Andressa Oliveira',
                      style: Styles.bodySmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Tipo:',
                      style: Styles.bodySmall.copyWith(
                          fontSize: 10.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Instalação',
                      style: Styles.bodySmall.copyWith(
                          fontSize: 10.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      'Endereço:',
                      style: Styles.bodySmall.copyWith(
                          fontSize: 10.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Rua Felipe Camarão 117, AP 89 Torre 2',
                      style: Styles.bodySmall.copyWith(
                          fontSize: 10.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                Icon(
                  FeatherIcons.user,
                  color: Colors.grey,
                  size: 16.w,
                ),
                SizedBox(width: 4.w),   
                Text(
                  'Thiago Oliveira',
                  style: Styles.bodySmall.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
