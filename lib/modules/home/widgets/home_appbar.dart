import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:executive_gps/modules/shared/resources/images.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeAppBar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.black,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primary),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
              Image.asset(
                Images.horizontalLogo,
                width: 120.w,
              ),
              SizedBox(width: 48.w), // Placeholder for alignment
            ],
          ),
          SizedBox(height: 12.h),
          AutoSizeText(
            'Bem-vindo, ${Modular.get<AuthBloc>().state.user?.name ?? 'Usuário'}!',
            maxLines: 2,
            style: Styles.bodyMedium.copyWith(color: AppColors.white),
          )
        ],
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: 140.h,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.h);
}
