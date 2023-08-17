import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/base/bloc_base.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/services/login.dart';
import 'package:adflaunt/product/services/register.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/constants/string_constants.dart';

part 'login_state.dart';

class LoginCubit extends BaseBloc<LoginState, LoginState> {
  LoginCubit() : super(LoginInitial());
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> login() async {
    safeEmit(LoginLoading());
    var bytes = utf8.encode(passwordController.text);
    var digest = sha512.convert(bytes);
    try {
      final res = await LoginAPI.login(
        emailController.text,
        digest.toString(),
        null,
        null,
      );
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final success = json['SCC'] as bool;
      if (res.statusCode == 200 && success) {
        ProfileModel profileModel = ProfileModel.fromJson(json);

        LoginAPI.saveAccountCredentials(ProfileAdapter(
          fullName: profileModel.fullName,
          email: profileModel.email,
          phoneNumber: profileModel.phoneNumber,
          dateOfBirth: profileModel.dateOfBirth,
          id: profileModel.id,
          idVerified: profileModel.idVerified,
          password: digest.toString(),
          photoOfId: '',
          profileImage: profileModel.profileImage ?? '',
          thirdParty: profileModel.thirdParty,
        ));

        safeEmit(LoginSuccess());
      } else {
        safeEmit(LoginFailure(error: json['err'].toString()));
      }
    } catch (e) {
      safeEmit(LoginFailure(error: e.toString()));
    }
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
          safeEmit(LoginSuccess());
        } else {
          safeEmit(LoginFailure(error: json['err'].toString()));
        }
      } else {
        safeEmit(LoginFailure(error: data.body));
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
    safeEmit(LoginLoading());
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
        safeEmit(LoginSuccess());
      } else {
        safeEmit(LoginFailure(error: json['err'].toString()));
      }
    } else {
      safeEmit(LoginFailure(error: data.body));
    }
  }

  void signInWithApple(String id) async {
    safeEmit(LoginLoading());
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
      safeEmit(LoginSuccess());
    } catch (e) {
      safeEmit(LoginFailure(error: e.toString()));
    }
  }
}
