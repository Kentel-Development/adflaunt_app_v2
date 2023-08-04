import 'dart:io';

import 'package:adflaunt/product/services/verify_id.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'verify_id_state.dart';

class VerifyIdCubit extends Cubit<VerifyIdState> {
  VerifyIdCubit() : super(VerifyIdInitial());
  final TextEditingController shippingAddressController =
      TextEditingController();
  void verifyId(File front, File back) async {
    emit(VerifyIdLoading());
    try {
      await VerificationAPI.verifyID(
          front, back, shippingAddressController.text);
      emit(VerifyIdSuccess());
    } catch (e) {
      emit(VerifyIdFailure(message: e.toString()));
    }
  }
}
