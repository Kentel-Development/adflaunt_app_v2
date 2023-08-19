import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:adflaunt/feature/login/login_view.dart';
import 'package:adflaunt/feature/register/code_verify_view.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/img_button.dart';
import 'package:adflaunt/product/widgets/inputs/auth_input.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import 'cubit/register_cubit.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterCodeSent) {
              RegisterCubit registerCubit = context.read<RegisterCubit>();
              Navigator.push(context, MaterialPageRoute<dynamic>(
                builder: (context) {
                  return CodeVerifyView(
                    registerCubit: registerCubit,
                  );
                },
              ));
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorConstants.colorPrimary,
                ),
              );
            } else if (state is RegisterSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (context) {
                    return TabView();
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Image.asset(IconConstants.logo),
                    SizedBox(height: size.height * 0.14),
                    Text(
                      S.of(context).signUp,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Form(
                        key: context.read<RegisterCubit>().key,
                        child: Column(
                          children: [
                            AuthInput(
                              placeholder: S.of(context).fullName,
                              keyBoardType: TextInputType.name,
                              controller:
                                  context.read<RegisterCubit>().nameController,
                              repeatController: null,
                            ),
                            const SizedBox(height: 8),
                            AuthInput(
                              placeholder: S.of(context).email,
                              keyBoardType: TextInputType.emailAddress,
                              controller:
                                  context.read<RegisterCubit>().emailController,
                              repeatController: null,
                            ),
                            const SizedBox(height: 8),
                            AuthInput(
                              placeholder: S.of(context).password,
                              keyBoardType: TextInputType.visiblePassword,
                              controller: context
                                  .read<RegisterCubit>()
                                  .passwordController,
                              repeatController: null,
                              hasPassword: true,
                            ),
                            const SizedBox(height: 8),
                            AuthInput(
                              placeholder: S.of(context).repeatPassword,
                              keyBoardType: TextInputType.visiblePassword,
                              controller: context
                                  .read<RegisterCubit>()
                                  .repeatPasswordController,
                              repeatController: context
                                  .read<RegisterCubit>()
                                  .passwordController,
                              hasPassword: true,
                            ),
                            buildPhoneInputField(state, context,
                                context.read<RegisterCubit>().phoneController),
                            const SizedBox(height: 8),
                            buildDatePicker(context),
                          ],
                        )),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingConstants.largePadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: CommonBtn(
                          onPressed: () {
                            if (context
                                .read<RegisterCubit>()
                                .key
                                .currentState!
                                .validate()) {
                              context.read<RegisterCubit>().signUp();
                            }
                          },
                          text: S.of(context).signUp,
                          backgroundColor: ColorConstants.colorPrimary,
                          textColor: ColorConstants.colorSecondary,
                          foregroundColor: ColorConstants.colorPrimary,
                          loading: state is RegisterLoading,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(S.of(context).or),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingConstants.largePadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ImgButton(
                          onPressed: () {
                            context.read<RegisterCubit>().google();
                          },
                          text: S.of(context).signUpWithGoogle,
                          img: IconConstants.google,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingConstants.largePadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ImgButton(
                          onPressed: () {
                            context.read<RegisterCubit>().apple();
                          },
                          text: S.of(context).signUpWithApple,
                          img: IconConstants.apple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: S.of(context).alreadyHaveAnAccount,
                        style: const TextStyle(
                          color: ColorConstants.colorTertiary,
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).logIn,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.colorPrimary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (context) {
                                      return LoginView();
                                    },
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ClipRRect buildPhoneInputField(RegisterState state, BuildContext context,
      TextEditingController phoneController) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AuthInput(
                enabled: state is! RegisterLoading,
                keyBoardType: TextInputType.phone,
                placeholder: S.of(context).phoneNumber,
                controller: phoneController,
                repeatController: null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CountryCodePicker(
                  onChanged: (CountryCode code) {
                    context.read<RegisterCubit>().changeCountryCode(code);
                  },
                  initialSelection: 'US',
                  favorite: const ['+1', '+44'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
              ),
            ),
          ],
        ));
  }

  AuthInput buildDatePicker(BuildContext context) {
    return AuthInput(
        enabled: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: context.read<RegisterCubit>().dateController.text == ""
                ? DateTime(DateTime.now().year - 18, DateTime.now().month,
                    DateTime.now().day)
                : DateFormat('dd/MM/yyyy')
                    .parse(context.read<RegisterCubit>().dateController.text),
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 120)),
            lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month,
                DateTime.now().day),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: ColorConstants.colorPrimary,
                    onPrimary: Colors.white,
                    onSurface: Color.fromRGBO(12, 12, 38, 1),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ColorConstants.colorPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                child: child!,
              );
            },
          ).then((value) {
            if (value != null) {
              context.read<RegisterCubit>().setDateOfBirth(value);
            }
          });
        },
        keyBoardType: TextInputType.datetime,
        controller: context.read<RegisterCubit>().dateController,
        placeholder: S.of(context).dateOfBirth,
        repeatController: null);
  }
}
