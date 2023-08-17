import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:adflaunt/feature/register/cubit/register_cubit.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../generated/l10n.dart';

class CodeVerifyView extends StatelessWidget {
  const CodeVerifyView({required this.registerCubit, super.key});
  final RegisterCubit registerCubit;
  @override
  Widget build(BuildContext context) {
    final otpController = OtpFieldController();
    return BlocProvider<RegisterCubit>.value(
      value: registerCubit,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(42),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Header(
                    hasBackBtn: true, title: S.of(context).verifyYourEmail),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: PaddingConstants.largePadding,
                        bottom: PaddingConstants.largePadding,
                        left: PaddingConstants.largePadding,
                        right: PaddingConstants.largePadding),
                    child: Center(
                      child: Text(
                          S.of(context).enterTheCodeWeSentOverEmailTo +
                              "\n" +
                              context
                                  .read<RegisterCubit>()
                                  .emailController
                                  .text
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: const Color.fromRGBO(119, 118, 130, 1),
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.02),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                    child: OTPTextField(
                      controller: otpController,
                      length: 5,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldWidth: 40,
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        errorBorderColor: Colors.white,
                        focusBorderColor: Colors.white,
                        enabledBorderColor: Colors.white,
                        disabledBorderColor: Colors.white,
                      ),
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 12,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(119, 118, 130, 1),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      onChanged: (pin) {
                        context.read<RegisterCubit>().onOtpChanged(pin);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: CommonBtn(
                        onPressed: () {
                          context.read<RegisterCubit>().verify();
                        },
                        text: S.of(context).confirm,
                        backgroundColor: ColorConstants.colorPrimary,
                        foregroundColor: ColorConstants.colorSecondary),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute<dynamic>(builder: (context) {
              return TabView();
            }), (route) => false);
          }
        },
      ),
    );
  }
}
