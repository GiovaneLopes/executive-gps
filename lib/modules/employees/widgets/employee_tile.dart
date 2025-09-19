import 'package:executive_gps/modules/shared/utils/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/modules/employees/widgets/info_action_line.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';

class EmployeeTile extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<EmployeeBloc>();

    return ExpansionTile(
      collapsedBackgroundColor: Colors.grey[50],
      backgroundColor: Colors.grey[50],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FeatherIcons.user,
            color: AppColors.primaryDark,
            size: 16.w,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              employee.name,
              maxLines: 2,
              style: Styles.bodySmall.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            onPressed: () => bloc.selectEmployee(employee),
            icon: const Icon(FeatherIcons.edit),
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.all(24.w),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoAction(
                label: 'Cpf',
                value: employee.cpf,
              ),
              InfoAction(
                label: 'Rg',
                value: employee.rg,
              ),
              InfoAction(
                label: 'Email',
                value: employee.email,
              ),
              InfoAction(
                label: 'Telefone',
                value: employee.mobile,
              ),
              InfoAction(
                value:
                    '${employee.address.logradouro}, ${employee.address.numero} - ${employee.address.bairro}, ${employee.address.localidade} - ${employee.address.uf}',
              ),
              Visibility(
                visible: employee.address.complemento?.isNotEmpty ?? false,
                child: Text('${employee.address.complemento}',
                    style: Styles.bodySmall),
              ),
              SizedBox(height: 12.h),
              Visibility(
                visible: employee.images.isNotEmpty,
                child: SizedBox(
                  height: 80.h,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: employee.images.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 2.w),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Modular.to.pushNamed('/image-details',
                              arguments: employee.images[index]),
                          child: Container(
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: AppColors.grey, width: 1.w),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      employee.images[index].url ?? ''),
                                )),
                            child: const SizedBox(),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      side: const BorderSide(color: AppColors.primary)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                onPressed: () => ContactHelper.call(employee.mobile),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.phoneCall,
                      size: 16.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Ligar',
                      style: Styles.body,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      side: const BorderSide(color: AppColors.primary)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                onPressed: () => ContactHelper.whatsapp(employee.mobile),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.messageCircle,
                      size: 16.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Whatsapp',
                      style: Styles.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
