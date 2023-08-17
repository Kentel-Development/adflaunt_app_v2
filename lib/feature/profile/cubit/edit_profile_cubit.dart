import 'dart:convert';
import 'dart:io';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/base/bloc_base.dart';
import 'package:adflaunt/core/extensions/date_parser_extension.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/services/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends BaseBloc<EditProfileState, EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  final currentUser = Hive.box<ProfileAdapter>('user').get('userData')!;
  late String name = currentUser.fullName!;
  late DateTime dateOfBirth = currentUser.dateOfBirth == null
      ? DateTime.now().subtract(Duration(days: 365 * 18))
      : currentUser.dateOfBirth!.parseDate();
  void changeProfileImage() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 1);
    if (pickedFile != null) {
      safeEmit(EditProfileLoading());
      try {
        await ProfileService.deleteOldImage();
        final editResponse = await ProfileService.editProfile(
            currentUser.email!,
            currentUser.password!,
            currentUser.fullName!,
            File(pickedFile.path),
            null);
        safeEmit(EditProfileInitial());
        final json = jsonDecode(editResponse.body) as Map<String, dynamic>;
        final updatedUser = ProfileModel.fromJson(json);
        Hive.box<ProfileAdapter>("user").put(
            "userData",
            ProfileAdapter(
                dateOfBirth: currentUser.dateOfBirth,
                email: currentUser.email,
                fullName: currentUser.fullName,
                id: currentUser.id,
                password: currentUser.password,
                phoneNumber: currentUser.phoneNumber,
                profileImage: updatedUser.profileImage));
      } catch (e) {
        safeEmit(EditProfileError(e.toString()));
      }
    }
  }

  void changeDateOfBirth(DateTime picked) {
    dateOfBirth = picked;
    safeEmit(EditProfileNotify());
    safeEmit(EditProfileInitial());
  }

  void saveChanges() async {
    safeEmit(EditProfileLoading());
    try {
      final editResponse = await ProfileService.editProfile(
          currentUser.email!, currentUser.password!, name, null, dateOfBirth);
      safeEmit(EditProfileInitial());
      final json = jsonDecode(editResponse.body) as Map<String, dynamic>;
      final updatedUser = ProfileModel.fromJson(json);
      Hive.box<ProfileAdapter>("user").put(
          "userData",
          ProfileAdapter(
              dateOfBirth: updatedUser.dateOfBirth,
              email: updatedUser.email,
              fullName: updatedUser.fullName,
              id: updatedUser.id,
              password: updatedUser.password,
              phoneNumber: updatedUser.phoneNumber,
              profileImage: updatedUser.profileImage));
      safeEmit(EditProfileSuccess());
    } catch (e) {
      safeEmit(EditProfileError(e.toString()));
    }
  }
}
