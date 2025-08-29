import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/modules/employees/widgets/employee_tile.dart';

class EmployeesContent extends StatelessWidget {
  const EmployeesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<EmployeeBloc>();
    return BlocBuilder<EmployeeBloc, EmployeeState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Row(
                  children: [
                    Text(
                      'Colaboradores',
                      style: Styles.bodyMedium.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
              state.status == EmployeeStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ))
                  : state.employees.isEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FeatherIcons.users,
                                color: AppColors.black,
                              ),
                              Text(
                                'Nenhum colaborador por aqui.',
                                style: Styles.bodySmall,
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemCount: state.employees.length,
                            itemBuilder: (context, index) {
                              final employee = state.employees[index];
                              return EmployeeTile(employee: employee);
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(height: 1);
                            },
                          ),
                        ),
            ],
          );
        });
  }
}
