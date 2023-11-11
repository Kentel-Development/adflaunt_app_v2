// ignore_for_file: inference_failure_on_function_invocation

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/product/services/profile.dart';
import 'package:adflaunt/product/services/verify.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../generated/l10n.dart';
import '../../product/widgets/common_btn.dart';
import '../../product/widgets/headers/main_header.dart';

class ChangePhoneNumberView extends StatefulWidget {
  const ChangePhoneNumberView(
      {super.key, this.sid, this.phone, this.code, this.email});
  final String? sid;
  final String? phone;
  final String? code;
  final String? email;

  @override
  State<ChangePhoneNumberView> createState() => _ChangePhoneNumberViewState();
}

class _ChangePhoneNumberViewState extends State<ChangePhoneNumberView> {
  final OtpFieldController otpController = OtpFieldController();
  String? pin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(
              hasBackBtn: true, title: S.of(context).verifyYourPhoneNumber),
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
                    S.of(context).enterTheCodeWeSentOverSmsTo +
                        "\n" +
                        (widget.phone ?? widget.email!),
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
                length: widget.code == null ? 6 : 5,
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
                onChanged: (pin2) {
                  setState(() {
                    pin = pin2;
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: CommonBtn(
                  onPressed: () async {
                    if (pin == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(S.of(context).pleaseEnterACode),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ));
                    } else if (widget.code == null
                        ? (pin!.length < 6)
                        : (pin!.length < 5)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(widget.code == null
                            ? S.of(context).yourCodeMustBe6Characters
                            : S.of(context).yourCodeMustBe5Characters),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ));
                    } else {
                      bool verify = widget.sid == null
                          ? widget.code == pin
                          : await VerifyService.verifyOtp(
                                  widget.sid!, pin!, widget.phone!)
                              .onError((error, stackTrace) {
                              return false;
                            });
                      if (verify) {
                        final user =
                            Hive.box<ProfileAdapter>('user').get("userData")!;
                        final res = await ProfileService.updateCredentials(
                            user.email!,
                            user.password!,
                            user.phoneNumber,
                            widget.email,
                            null,
                            widget.phone);
                        if (res.statusCode == 200) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(S.of(context).success),
                                content: Text(widget.code == null
                                    ? S
                                        .of(context)
                                        .yourPhoneNumberWasSuccesfullyChanged
                                    : S
                                        .of(context)
                                        .yourEmailWasChangedSuccesfully),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"))
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(S.of(context).failed),
                                content: Text(S.of(context).unexpectedProblem),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"))
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(widget.code == null
                              ? S
                                  .of(context)
                                  .cantVerifiedYourPhoneNumberPleaseTryAgain
                              : S
                                  .of(context)
                                  .cantVerifiedYourEmailPleaseTryAgain),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));
                      }
                    }
                  },
                  text: S.of(context).confirm,
                  backgroundColor: ColorConstants.colorPrimary,
                  foregroundColor: ColorConstants.colorSecondary),
            )
          ],
        ),
      ),
    );
  }
}
