import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 72.w,
                        height: 72.w,
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primaryDark,
                          child: Icon(
                            FeatherIcons.user,
                            size: 40,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        'Olá, Everton Angelo',
                        style: Styles.bodyMedium.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(
              'Meus dados',
              style: Styles.bodySmall,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          const Spacer(),
          SafeArea(
            child: ListTile(
              title: Text(
                'Sair',
                style: Styles.bodySmall,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.black,
              ),
              onTap: () {
                Modular.get<AuthBloc>().logout();
                Modular.to.popUntil((route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
