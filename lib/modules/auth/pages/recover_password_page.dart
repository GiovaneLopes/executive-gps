import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/snackbar_widget.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';
import 'package:executive_gps/modules/shared/ui/custom_text_form_field.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final bloc = Modular.get<AuthBloc>();
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'Esqueci a senha',
          style: Styles.body.copyWith(color: AppColors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: Modular.to.pop,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 120.h),
              Text(
                'Digite o email cadastrado para recuperar a senha',
                style: Styles.body.copyWith(color: AppColors.white),
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                validator: InputValidators.validateEmail,
              ),
              SizedBox(height: 12.h),
              BlocConsumer<AuthBloc, AuthState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state.status == AuthStatus.error) {
                      SnackbarWidget.mostrar(
                        context,
                        title: 'Erro',
                        message: state.error?.message,
                        type: SnackbarWidgetType.error,
                      );
                    } else if (state.status == AuthStatus.loaded) {
                      SnackbarWidget.mostrar(
                        context,
                        title: 'Sucesso',
                        message:
                            'Email de recuperação de senha enviado com sucesso',
                        type: SnackbarWidgetType.success,
                      );
                      Modular.to.pop();
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      label: 'Email',
                      loading: state.status == AuthStatus.loading,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          bloc.recoverPassword(emailController.text);
                        }
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
