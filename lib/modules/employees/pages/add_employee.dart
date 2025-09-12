import 'dart:io';
import 'package:executive_gps/modules/shared/ui/new_photo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/home/home_routes.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/ui/custom_dialog.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/snackbar_widget.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/employees/blocs/employee_bloc.dart';
import 'package:executive_gps/modules/shared/utils/input_formatters.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/shared/ui/custom_text_form_field.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final bloc = Modular.get<EmployeeBloc>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final rgController = TextEditingController();
  final cpfController = TextEditingController();
  final cepController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final complementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (bloc.state.selectedEmployee != null) {
      nameController.text = bloc.state.selectedEmployee?.name ?? '';
      emailController.text = bloc.state.selectedEmployee?.email ?? '';
      phoneController.text = bloc.state.selectedEmployee?.mobile ?? '';
      rgController.text = bloc.state.selectedEmployee?.rg ?? '';
      cpfController.text = bloc.state.selectedEmployee?.cpf ?? '';
      cepController.text = bloc.state.selectedEmployee?.address.cep ?? '';
      cityController.text =
          bloc.state.selectedEmployee?.address.localidade ?? '';
      stateController.text = bloc.state.selectedEmployee?.address.uf ?? '';
      neighborhoodController.text =
          bloc.state.selectedEmployee?.address.bairro ?? '';
      streetController.text =
          bloc.state.selectedEmployee?.address.logradouro ?? '';
      numberController.text = bloc.state.selectedEmployee?.address.numero ?? '';
      complementController.text =
          bloc.state.selectedEmployee?.address.complemento ?? '';
    }
  }

  void validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      final employee = EmployeeModel(
        id: bloc.state.selectedEmployee?.id,
        name: nameController.text,
        mobile: phoneController.text,
        email: emailController.text,
        rg: rgController.text,
        cpf: cpfController.text,
        images: bloc.state.selectedEmployee?.images ?? [],
        address: AddressModel(
          cep: cepController.text,
          localidade: cityController.text,
          uf: stateController.text,
          bairro: neighborhoodController.text,
          logradouro: streetController.text,
          numero: numberController.text,
          complemento: complementController.text,
        ),
        isAdmin: bloc.state.isAdmin,
      );
      if (bloc.state.selectedEmployee != null) {
        bloc.updateEmployee(employee);
      } else {
        bloc.addEmployee(employee);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          bloc.state.selectedEmployee == null
              ? 'Novo colaborador'
              : 'Editar perfil',
          style: Styles.bodyMedium,
        ),
        actions: [
          Visibility(
            visible: bloc.state.selectedEmployee != null &&
                bloc.state.selectedEmployee?.id !=
                    Modular.get<AuthBloc>().state.user?.id,
            child: IconButton(
              icon: const Icon(FeatherIcons.trash2, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                        title: 'Excluir colaborador',
                        content: Text(
                          'Você tem certeza que deseja excluir este colaborador?',
                          style: Styles.bodySmall,
                        ),
                        onTap: (confirm) {
                          if (confirm) {
                            bloc.deleteEmployee();
                            Modular.to.popUntil((route) =>
                                route.settings.name == HomeRoutes.home.module);
                          } else {
                            Modular.to.pop();
                          }
                        });
                  },
                );
              },
            ),
          )
        ],
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: Modular.to.pop,
        ),
      ),
      persistentFooterButtons: [
        BlocConsumer<EmployeeBloc, EmployeeState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.status == EmployeeStatus.error) {
                SnackbarWidget.mostrar(
                  context,
                  title: 'Erro',
                  message: state.error?.message,
                  type: SnackbarWidgetType.error,
                );
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                onPressed: validateForm,
                loading: state.status == EmployeeStatus.loading,
                label: 'Salvar',
              );
            }),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: BlocConsumer<EmployeeBloc, EmployeeState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.status == EmployeeStatus.success) {
                Modular.to.popUntil(
                    (route) => route.settings.name == HomeRoutes.home.module);
              }
            },
            builder: (context, state) {
              if (state.status == EmployeeStatus.addressLoaded) {
                cityController.text = state.address?.localidade ?? '';
                stateController.text = state.address?.uf ?? '';
                neighborhoodController.text = state.address?.bairro ?? '';
                streetController.text = state.address?.logradouro ?? '';
                numberController.text = state.address?.numero ?? '';
                complementController.text = state.address?.complemento ?? '';
                validateForm();
              }
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dados',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Nome completo',
                      controller: nameController,
                      validator: InputValidators.validateName,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'E-mail',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidators.validateEmail,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Telefone',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: InputValidators.validateMobile,
                      inputFormatters: InputFormatters.phoneNumberFormatter,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Rg',
                      controller: rgController,
                      validator: InputValidators.validateRg,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Cpf',
                      controller: cpfController,
                      keyboardType: TextInputType.number,
                      inputFormatters: InputFormatters.cpfFormatter,
                      validator: InputValidators.validateCpf,
                    ),
                    SizedBox(height: 14.h),
                    Visibility(
                      visible:
                          Modular.get<AuthBloc>().state.user?.isAdmin == true &&
                              bloc.state.selectedEmployee !=
                                  Modular.get<AuthBloc>().state.user,
                      child: SwitchListTile(
                        title: Text(
                          'Administrador',
                          style: Styles.bodySmall,
                        ),
                        value: state.isAdmin,
                        onChanged: (value) {
                          if (value) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                      title: 'Tornar Administrador',
                                      content: Text(
                                        'Você tem certeza que deseja tornar este colaborador Administrador?',
                                        style: Styles.bodySmall,
                                      ),
                                      onTap: (confirm) {
                                        if (confirm) {
                                          bloc.updateAdmin();
                                        }
                                        Modular.to.pop();
                                      });
                                });
                          } else {
                            bloc.updateAdmin();
                          }
                        },
                      ),
                    ),
                    Text(
                      'Endereço',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'CEP',
                      controller: cepController,
                      keyboardType: TextInputType.number,
                      loading: state.status == EmployeeStatus.addressLoading,
                      inputFormatters: InputFormatters.cepFormatter,
                      validator: InputValidators.validateCep,
                      onChanged: (value) {
                        if (value.length == 9) {
                          bloc.searchAddress(cepController.text);
                        }
                      },
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Cidade',
                      enabled: state.status != EmployeeStatus.addressLoading,
                      controller: cityController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Estado',
                      enabled: state.status != EmployeeStatus.addressLoading,
                      controller: stateController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Bairro',
                      enabled: state.status != EmployeeStatus.addressLoading,
                      controller: neighborhoodController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Rua',
                      enabled: state.status != EmployeeStatus.addressLoading,
                      controller: streetController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Número',
                      controller: numberController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Complemento',
                      controller: complementController,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Fotos',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      runSpacing: 12.w,
                      spacing: 4.w,
                      children: [
                        ...List.generate(state.images.length, (index) {
                          return Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () => Modular.to.pushNamed(
                                    '/image-details',
                                    arguments: state.images[index]),
                                child: Container(
                                  width: 100.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: AppColors.grey, width: 1.w),
                                    image: state.images[index].url != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                state.images[index].url ?? ''),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(
                                                state.images[index].file
                                                        ?.path ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                  ),
                                  child: const SizedBox(),
                                ),
                              ),
                              Positioned(
                                  top: -10.w,
                                  child: Container(
                                    width: 28.w,
                                    height: 28.w,
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32.r),
                                      color: Colors.red,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.w,
                                      ),
                                    ),
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: Colors.red,
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 14.w,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomDialog(
                                                    title: 'Excluir imagem',
                                                    content: Text(
                                                      'Você tem certeza que deseja excluir esta imagem?',
                                                      style: Styles.bodySmall,
                                                    ),
                                                    onTap: (confirm) {
                                                      if (confirm) {
                                                        bloc.deleteImage(state
                                                            .images[index]);
                                                      }
                                                      Modular.to.pop();
                                                    });
                                              });
                                        }),
                                  )),
                            ],
                          );
                        }),
                        if (Modular.get<AuthBloc>().state.user?.isAdmin == true)
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return NewPhotoDialog(
                                    onNewPhoto: (image) {
                                      bloc.addImage(image);
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: AppColors.grey, width: 1.w),
                              ),
                              child: Icon(Icons.add_circle_outline_rounded,
                                  color: AppColors.grey, size: 32.w),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
