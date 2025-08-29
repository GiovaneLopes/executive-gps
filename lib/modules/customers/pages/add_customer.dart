import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/home/home_routes.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/ui/custom_dialog.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/snackbar_widget.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/customers/blocs/customer_bloc.dart';
import 'package:executive_gps/modules/shared/utils/input_formatters.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/shared/ui/custom_text_form_field.dart';
import 'package:executive_gps/libs/modules/address/models/address_model.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final bloc = Modular.get<CustomerBloc>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final observationsController = TextEditingController();
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
    if (bloc.state.selectedCustomer != null) {
      nameController.text = bloc.state.selectedCustomer?.name ?? '';
      emailController.text = bloc.state.selectedCustomer?.email ?? '';
      phoneController.text = bloc.state.selectedCustomer?.mobile ?? '';
      cpfController.text = bloc.state.selectedCustomer?.cpf ?? '';
      observationsController.text =
          bloc.state.selectedCustomer?.observations ?? '';
      cepController.text = bloc.state.selectedCustomer?.address.cep ?? '';
      cityController.text =
          bloc.state.selectedCustomer?.address.localidade ?? '';
      stateController.text = bloc.state.selectedCustomer?.address.uf ?? '';
      neighborhoodController.text =
          bloc.state.selectedCustomer?.address.bairro ?? '';
      streetController.text =
          bloc.state.selectedCustomer?.address.logradouro ?? '';
      numberController.text = bloc.state.selectedCustomer?.address.numero ?? '';
      complementController.text =
          bloc.state.selectedCustomer?.address.complemento ?? '';
    }
  }

  void validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      final customer = CustomerModel(
        id: bloc.state.selectedCustomer?.id,
        name: nameController.text,
        mobile: phoneController.text,
        email: emailController.text,
        cpf: cpfController.text,
        images: bloc.state.selectedCustomer?.images ?? [],
        observations: observationsController.text,
        address: AddressModel(
          cep: cepController.text,
          localidade: cityController.text,
          uf: stateController.text,
          bairro: neighborhoodController.text,
          logradouro: streetController.text,
          numero: numberController.text,
          complemento: complementController.text,
        ),
      );
      if (bloc.state.selectedCustomer != null) {
        bloc.updateCustomer(customer);
      } else {
        bloc.addCustomer(customer);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          bloc.state.selectedCustomer == null
              ? 'Novo cliente'
              : 'Editar cliente',
          style: Styles.bodyMedium,
        ),
        actions: [
          Visibility(
            visible: bloc.state.selectedCustomer != null,
            child: IconButton(
              icon: const Icon(FeatherIcons.trash2, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                        title: 'Excluir cliente',
                        content: Text(
                          'Você tem certeza que deseja excluir este cliente?',
                          style: Styles.bodySmall,
                        ),
                        onTap: (confirm) {
                          if (confirm) {
                            bloc.deleteCustomer();
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
        BlocConsumer<CustomerBloc, CustomerState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.status == CustomerStatus.error) {
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
                loading: state.status == CustomerStatus.loading,
                label: 'Salvar',
              );
            }),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: BlocConsumer<CustomerBloc, CustomerState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.status == CustomerStatus.success) {
                Modular.to.popUntil(
                    (route) => route.settings.name == HomeRoutes.home.module);
              }
            },
            builder: (context, state) {
              if (state.status == CustomerStatus.addressLoaded) {
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
                      labelText: 'Cpf',
                      controller: cpfController,
                      keyboardType: TextInputType.number,
                      inputFormatters: InputFormatters.cpfFormatter,
                      validator: InputValidators.validateCpf,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Observações',
                      controller: observationsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Endereço',
                      style: Styles.bodyMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'CEP',
                      controller: cepController,
                      keyboardType: TextInputType.number,
                      loading: state.status == CustomerStatus.addressLoading,
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
                      enabled: state.status != CustomerStatus.addressLoading,
                      controller: cityController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Estado',
                      enabled: state.status != CustomerStatus.addressLoading,
                      controller: stateController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Bairro',
                      enabled: state.status != CustomerStatus.addressLoading,
                      controller: neighborhoodController,
                      validator: InputValidators.validateEmpty,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField.light(
                      labelText: 'Rua',
                      enabled: state.status != CustomerStatus.addressLoading,
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
                                onTap: () =>
                                    bloc.selectImage(state.images[index]),
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
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  title: 'Adicionar documento',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.gallery,
                                        )
                                            .then((image) {
                                          if (image != null) {
                                            bloc.addImage(image);
                                          }
                                        });
                                        Modular.to.pop();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            FeatherIcons.image,
                                            color: AppColors.grey,
                                            size: 24.w,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              'Galeria',
                                              style: Styles.body.copyWith(
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            FeatherIcons.chevronRight,
                                            color: AppColors.grey,
                                            size: 24.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    const Divider(),
                                    SizedBox(height: 8.h),
                                    TextButton(
                                      onPressed: () async {
                                        await ImagePicker()
                                            .pickImage(
                                          source: ImageSource.camera,
                                        )
                                            .then((image) {
                                          if (image != null) {
                                            bloc.addImage(image);
                                          }
                                        });
                                        Modular.to.pop();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            FeatherIcons.camera,
                                            color: AppColors.grey,
                                            size: 24.w,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              'Câmera',
                                              style: Styles.body.copyWith(
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            FeatherIcons.chevronRight,
                                            color: AppColors.grey,
                                            size: 24.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border:
                                  Border.all(color: AppColors.grey, width: 1.w),
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
