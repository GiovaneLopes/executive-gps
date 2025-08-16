import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/auth/auth_routes.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/images.dart';
import 'package:executive_gps/modules/shared/ui/snackbar_widget.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/utils/input_validators.dart';
import 'package:executive_gps/modules/shared/ui/custom_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final bloc = Modular.get<AuthBloc>();

  void onDone() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      bloc.signIn(
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: BlocConsumer<AuthBloc, AuthState>(
              bloc: bloc,
              listener: (context, state) {
                if (state.status == AuthStatus.error) {
                  SnackbarWidget.mostrar(
                    context,
                    title: 'Erro',
                    message: state.error?.message,
                    type: SnackbarWidgetType.error,
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            width: 180.w,
                            child: Image.asset(Images.horizontalLogo),
                          ),
                        ),
                        SizedBox(height: 70.h),
                        Text(
                          'Olá! Faça seu login',
                          style: Styles.title.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Insira seu email e senha para acessar',
                          style: Styles.bodyMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          controller: emailController,
                          validator: InputValidators.validateEmail,
                          onEditingComplete:
                              FocusManager.instance.primaryFocus?.nextFocus,
                        ),
                        SizedBox(height: 12.h),
                        CustomTextFormField(
                          hintText: 'Senha',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: bloc.updateObscurePassword,
                            icon: Icon(
                              state.obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            color: AppColors.white,
                          ),
                          obscureText: state.obscurePassword,
                          controller: passwordController,
                          validator: InputValidators.validatePassword,
                          onEditingComplete: onDone,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: AuthRoutes.recoverPassword.navigate,
                              child: Text(
                                'Esqueci a senha',
                                style: Styles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 56.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  onPressed: onDone,
                                  child: state.status == AuthStatus.loading
                                      ? SizedBox(
                                          width: 20.w,
                                          height: 20.w,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.black,
                                          ))
                                      : Text(
                                          'Entrar',
                                          style: Styles.bodyMedium.copyWith(
                                            color: AppColors.black,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
