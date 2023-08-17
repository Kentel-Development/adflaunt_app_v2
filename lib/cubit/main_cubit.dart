import 'dart:convert';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/services/login.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../product/services/network_checker.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  INetworkChangeManager networkChange = NetworkChangeManager();

  void checkConnection() {
    networkChange.checkNetworkFirstTime().then((result) {
      if (result == NetworkResult.off) {
        emit(MainNoInternet());
      } else {
        checkLogin();
      }
    });
    networkChange.handleNetworkChange((result) {
      if (result == NetworkResult.off) {
        emit(MainNoInternet());
      } else {
        checkLogin();
      }
    });
  }

  void checkLogin() async {
    final currentUser = Hive.box<ProfileAdapter>('user').get('userData');
    if (currentUser == null ||
        currentUser.email == null ||
        currentUser.password == null ||
        currentUser.email == "" ||
        currentUser.password == "") {
      emit(MainLoggedOut());
    } else {
      emit(MainLoading());
      final response = await LoginAPI.login(
          currentUser.email!, currentUser.password!, null, null);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final model = ProfileModel.fromJson(json);
      if (response.statusCode == 200 && json["SCC"] == true) {
        await LoginAPI.saveAccountCredentials(ProfileAdapter(
          dateOfBirth: model.dateOfBirth,
          email: model.email,
          fullName: model.fullName,
          id: model.id,
          password: model.password,
          phoneNumber: model.phoneNumber,
          profileImage: model.profileImage,
          idVerified: model.idVerified,
        ));
        emit(MainLoggedIn());
      } else {
        emit(MainLoggedOut());
      }
    }
  }
}
