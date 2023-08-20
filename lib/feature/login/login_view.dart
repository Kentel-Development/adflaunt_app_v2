import 'dart:io';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:adflaunt/feature/login/cubit/login_cubit.dart';
import 'package:adflaunt/feature/register/register_view.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/img_button.dart';
import 'package:adflaunt/product/widgets/inputs/auth_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute<dynamic>(
                builder: (context) {
                  return TabView();
                },
              ), (route) => false);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorConstants.colorPrimary,
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
                      S.of(context).logIn,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Form(
                        key: context.read<LoginCubit>().key,
                        child: Column(
                          children: [
                            AuthInput(
                              placeholder: S.of(context).email,
                              keyBoardType: TextInputType.emailAddress,
                              controller:
                                  context.read<LoginCubit>().emailController,
                              repeatController: null,
                            ),
                            const SizedBox(height: 8),
                            AuthInput(
                              placeholder: S.of(context).password,
                              keyBoardType: TextInputType.visiblePassword,
                              controller:
                                  context.read<LoginCubit>().passwordController,
                              repeatController: null,
                              hasPassword: true,
                            ),
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
                                    .read<LoginCubit>()
                                    .key
                                    .currentState!
                                    .validate() ==
                                true) {
                              context.read<LoginCubit>().login();
                            }
                          },
                          text: S.of(context).logIn,
                          backgroundColor: ColorConstants.colorPrimary,
                          textColor: ColorConstants.colorSecondary,
                          foregroundColor: ColorConstants.colorPrimary,
                          loading: state is LoginLoading,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Or'),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingConstants.largePadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ImgButton(
                          onPressed: () {
                            context.read<LoginCubit>().google();
                          },
                          text: S.of(context).logInWithGoogle,
                          img: IconConstants.google,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Platform.isAndroid
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: PaddingConstants.largePadding,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ImgButton(
                                onPressed: () {
                                  context.read<LoginCubit>().apple();
                                },
                                text: S.of(context).logInWithApple,
                                img: IconConstants.apple,
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: S.of(context).newHere + ' ',
                        style: const TextStyle(
                          color: ColorConstants.colorTertiary,
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).signUp,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.colorPrimary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                    MaterialPageRoute<dynamic>(
                                  builder: (context) {
                                    return RegisterView();
                                  },
                                ));
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
}
