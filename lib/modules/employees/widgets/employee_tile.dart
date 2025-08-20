import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';

class EmployeeTile extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<EmployeeBloc>();
    return Container(
      color: AppColors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        onTap: () => bloc.selectEmployee(employee),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              FeatherIcons.user,
              color: AppColors.primary,
              size: 16.w,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                employee.name ,
                style: Styles.bodySmall.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              employee.cpf,
              textAlign: TextAlign.end,
              style: Styles.bodySmall,
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.email,
                style: Styles.bodySmall,
              ),
              SizedBox(height: 10.h),
              Text(employee.mobile, style: Styles.bodySmall),
              SizedBox(height: 10.h),
              Text(
                  '${employee.address.logradouro}, ${employee.address.numero} - ${employee.address.bairro}, ${employee.address.localidade} - ${employee.address.uf}',
                  style: Styles.bodySmall),
              Visibility(
                visible: employee.address.complemento?.isNotEmpty ?? false,
                child: Text('${employee.address.complemento}',
                    style: Styles.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
