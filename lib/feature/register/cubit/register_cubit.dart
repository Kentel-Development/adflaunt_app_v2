import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/base/bloc_base.dart';
import 'package:adflaunt/core/extensions/date_parser_extension.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/adapters/profile/profile_adapter.dart';
import '../../../core/constants/string_constants.dart';
import '../../../product/models/profile/profile_model.dart';
import '../../../product/services/login.dart';
import '../../../product/services/register.dart';

part 'register_state.dart';

class RegisterCubit extends BaseBloc<RegisterState, RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  CountryCode countryCode = CountryCode.fromCountryCode('US');
  final key = GlobalKey<FormState>();
  String? pin;
  String sentCode = "";

  void onOtpChanged(String value) {
    pin = value;
  }

  void signUp() async {
    // Navigate user to email code verification page
    print(emailController.text);
    print(countryCode.dialCode.toString() + phoneController.text);
    safeEmit(RegisterLoading());
    final checkUser = await Register.userCheck(emailController.text,
        (countryCode.dialCode.toString().substring(1)) + phoneController.text);
    if (checkUser.emailExists == true && checkUser.phoneNumberExists == true) {
      safeEmit(RegisterFailure(error: "Email and phone number already exists"));
    } else if (checkUser.emailExists == true) {
      safeEmit(RegisterFailure(error: "Email already exists"));
    } else if (checkUser.phoneNumberExists == true) {
      safeEmit(RegisterFailure(error: "Phone number already exists"));
    } else {
      sentCode = await Register.verifyEmail(emailController.text);
      safeEmit(RegisterCodeSent(verificationId: sentCode));
    }
  }

  void changeCountryCode(CountryCode code) {
    countryCode = code;
  }

  void setDateOfBirth(DateTime value) {
    dateController.text = DateFormat('dd/MM/yyyy').format(value);
  }

  void google() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(clientId: StringConstants.googleClientID);

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final data = await Register.google(
          googleSignInAccount.id,
          googleSignInAccount.email,
          googleSignInAccount.photoUrl,
          googleSignInAccount.displayName!);
      Map<String, dynamic> json = jsonDecode(data.body) as Map<String, dynamic>;
      if (data.statusCode == 200) {
        if (json["SCC"] == true) {
          final model = ProfileModel.fromJson(json);
          LoginAPI.saveAccountCredentials(
            ProfileAdapter(
                id: model.id,
                fullName: model.fullName,
                email: model.email,
                password: model.password,
                profileImage: model.profileImage,
                dateOfBirth: model.dateOfBirth,
                phoneNumber: model.phoneNumber),
          );
          safeEmit(RegisterSuccess());
        } else {
          safeEmit(RegisterFailure(error: json["err"].toString()));
        }
      } else {
        safeEmit(RegisterFailure(error: data.body));
      }
    }
  }

  void apple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    log(credential.toString());
    log(credential.userIdentifier!);
    switch (credential.email) {
      case null:
        signInWithApple(credential.userIdentifier!);
        break;
      default:
        signUpWithApple(credential.email!, credential.givenName ?? "",
            credential.familyName ?? "", credential.userIdentifier!);
    }
  }

  void signUpWithApple(
      String email, String firstName, String lastName, String id) async {
    safeEmit(RegisterLoading());
    final data = await Register.apple(firstName, lastName, email, id);
    if (data.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(data.body) as Map<String, dynamic>;
      final model = ProfileModel.fromJson(json);
      if (model.scc == true) {
        LoginAPI.saveAccountCredentials(
          ProfileAdapter(
              id: model.id,
              fullName: model.fullName,
              email: model.email,
              password: model.password,
              profileImage: model.profileImage,
              dateOfBirth: model.dateOfBirth,
              phoneNumber: model.phoneNumber),
        );
        safeEmit(RegisterSuccess());
      } else {
        safeEmit(RegisterFailure(error: json['err'].toString()));
      }
    } else {
      safeEmit(RegisterFailure(error: data.body));
    }
  }

  void signInWithApple(String id) async {
    safeEmit(RegisterLoading());
    try {
      final data = await Register.appleLogin(id);
      Map<String, dynamic> json = jsonDecode(data.body) as Map<String, dynamic>;
      final registerModel = ProfileModel.fromJson(json);
      LoginAPI.saveAccountCredentials(
        ProfileAdapter(
            id: registerModel.id,
            fullName: registerModel.fullName,
            email: registerModel.email,
            password: registerModel.password,
            profileImage: registerModel.profileImage ?? "",
            dateOfBirth: registerModel.dateOfBirth,
            phoneNumber: registerModel.phoneNumber),
      );
      safeEmit(RegisterSuccess());
    } catch (e) {
      safeEmit(RegisterFailure(error: e.toString()));
    }
  }

  void verify() async {
    safeEmit(RegisterLoading());
    if (pin == sentCode) {
      try {
        var bytes = utf8.encode(passwordController.text);
        var digest = sha512.convert(bytes);
        final data = await Register.register(
            emailController.text,
            digest.toString(),
            nameController.text,
            (countryCode.dialCode.toString().substring(1)) +
                phoneController.text,
            dateController.text.parseDate(),
            "mail");
        Map<String, dynamic> json =
            jsonDecode(data.body) as Map<String, dynamic>;
        final model = ProfileModel.fromJson(json);

        LoginAPI.saveAccountCredentials(
          ProfileAdapter(
              id: model.id,
              fullName: model.fullName,
              email: model.email,
              password: model.password,
              profileImage: model.profileImage,
              dateOfBirth: model.dateOfBirth,
              phoneNumber: model.phoneNumber),
        );
        safeEmit(RegisterSuccess());
      } catch (e) {
        safeEmit(RegisterFailure(error: e.toString()));
      }
    } else {
      safeEmit(RegisterFailure(error: "Invalid code"));
    }
  }
}
