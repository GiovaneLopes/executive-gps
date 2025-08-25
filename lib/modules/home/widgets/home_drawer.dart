import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/home/blocs/home_bloc.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';

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
                        width: 45.w,
                        height: 45.w,
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primaryDark,
                          child: Icon(
                            FeatherIcons.user,
                            size: 28,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<AuthBloc, AuthState>(
                                bloc: Modular.get<AuthBloc>(),
                                builder: (context, state) {
                                  return AutoSizeText(
                                    'Olá, ${state.user?.name ?? 'Usuário'}',
                                    minFontSize: 6,
                                    maxLines: 1,
                                    style: Styles.body.copyWith(
                                      color: AppColors.black,   
                                    ),
                                  );
                                }),
                          ),
                        ],
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
              Modular.get<EmployeeBloc>().selectEmployee(
                  Modular.get<EmployeeBloc>().state.employees.firstWhere(
                        (emp) =>
                            emp.id == Modular.get<AuthBloc>().state.user?.id,
                      ));
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
                Modular.get<HomeBloc>().clear();
                Modular.to.popUntil((route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
