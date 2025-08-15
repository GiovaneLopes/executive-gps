import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/shared/resources/images.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart'
    show AppColors;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.logo,
              width: 150.w,
            ),
             SizedBox(height: 36.h),
            SizedBox(
              height: 24.w,
              width: 24.w,
              child: const CircularProgressIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
