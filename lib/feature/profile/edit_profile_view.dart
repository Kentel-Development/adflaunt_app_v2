import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/profile/cubit/edit_profile_cubit.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({required this.userModel, super.key});
  final ProfileModel userModel;
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return state is EditProfileLoading || state is EditProfileError
                ? Container(
                    height: 0,
                  )
                : Container(
                    color: Colors.white,
                    child: SafeArea(
                        child: Padding(
                      padding: EdgeInsets.only(left: 22, right: 22, top: 12),
                      child: GestureDetector(
                        onTap: () {
                          context.read<EditProfileCubit>().saveChanges();
                        },
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: ColorConstants.colorPrimary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).save,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )),
                      ),
                    )),
                  );
          },
        ),
        backgroundColor: ColorConstants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Header(hasBackBtn: true, title: 'Edit Profile'),
          ),
        ),
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is EditProfileSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is EditProfileLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            } else
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    ValueListenableBuilder(
                        valueListenable:
                            Hive.box<ProfileAdapter>('user').listenable(),
                        builder: (context, Box<ProfileAdapter> box, child) {
                          final userData = box.get('userData')!;
                          return Center(
                            child: Stack(
                              children: [
                                userData.profileImage != null ||
                                        userData.profileImage != ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, right: 8),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey[400],
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            StringConstants.baseStorageUrl +
                                                userData.profileImage!
                                                    .toString(),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, right: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[300],
                                          radius: 50,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 80,
                                          ),
                                        ),
                                      ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<EditProfileCubit>()
                                          .changeProfileImage();
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          IconConstants.container,
                                        ),
                                        Image.asset(IconConstants.edit_line),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: TextEditingController(
                          text: context.read<EditProfileCubit>().name,
                        ),
                        onChanged: (value) {
                          context.read<EditProfileCubit>().name = value;
                        },
                        cursorColor: ColorConstants.grey300,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: S.of(context).exJohnDoe,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: ColorConstants.grey300,
                            ),
                          ),
                          focusColor: ColorConstants.grey300,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: ColorConstants.grey300,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: ColorConstants.grey300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).dateOfBirth,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
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
                                    backgroundColor:
                                        ColorConstants.colorPrimary,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          initialDate:
                              context.read<EditProfileCubit>().dateOfBirth,
                          firstDate: DateTime(1900, 1),
                          lastDate:
                              DateTime.now().subtract(Duration(days: 365 * 18)),
                        );

                        if (picked != null &&
                            picked !=
                                context.read<EditProfileCubit>().dateOfBirth) {
                          context
                              .read<EditProfileCubit>()
                              .changeDateOfBirth(picked);
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorConstants.grey100),
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SvgPicture.asset(IconConstants.installation),
                            SizedBox(
                              width: 8,
                            ),
                            Text(DateFormat(StringConstants.dateFormat).format(
                                context.read<EditProfileCubit>().dateOfBirth)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
