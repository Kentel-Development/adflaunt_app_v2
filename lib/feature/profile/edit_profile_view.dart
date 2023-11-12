// ignore_for_file: inference_failure_on_function_invocation, inference_failure_on_instance_creation

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/change_phone/change_phone_view.dart';
import 'package:adflaunt/feature/profile/cubit/edit_profile_cubit.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/services/register.dart';
import 'package:adflaunt/product/services/verify.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../../product/widgets/inputs/auth_input.dart';

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
            return state is EditProfileLoading
                ? Container(
                    height: 0,
                  )
                : Container(
                    color: Colors.white,
                    child: SafeArea(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: 22, right: 22, top: 12, bottom: 12),
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
            child: Header(hasBackBtn: true, title: S.of(context).editProfile),
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
                                userData.profileImage != null &&
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
                        S.of(context).fullName,
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
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).phoneNumber,
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
                        TextEditingController phoneController =
                            TextEditingController();
                        CountryCode countryCode =
                            CountryCode.fromCountryCode("US");
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              title: Text(S.of(context).changeYourPhoneNumber),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () async {
                                      if (phoneController.text.length < 10) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .pleaseProvideAValidPhoneNumber),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ));
                                      } else {
                                        final check = await Register.userCheck(
                                            null,
                                            (countryCode.dialCode! +
                                                phoneController.text));
                                        if (check.phoneNumberExists!) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .thisPhoneNumberIsAlreadyInUse),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ));
                                        } else {
                                          String sid = await VerifyService
                                              .createSession();
                                          bool sent =
                                              await VerifyService.sendOtp(
                                                      (countryCode.dialCode! +
                                                          phoneController.text),
                                                      sid)
                                                  .onError((error, stackTrace) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(error.toString()),
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ));
                                            return false;
                                          });
                                          if (sent) {
                                            Navigator.pop(context);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return ChangePhoneNumberView(
                                                  sid: sid,
                                                  phone:
                                                      (countryCode.dialCode! +
                                                          phoneController.text),
                                                );
                                              },
                                            )).then((value) {
                                              setState(() {});
                                            });
                                          }
                                        }
                                      }
                                    },
                                    child: Text("OK"))
                              ],
                              content: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: AuthInput(
                                          enabled: true,
                                          keyBoardType: TextInputType.phone,
                                          placeholder:
                                              S.of(context).phoneNumber,
                                          controller: phoneController,
                                          repeatController: null,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CountryCodePicker(
                                            onChanged: (CountryCode code) {
                                              countryCode = code;
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
                                  )),
                            );
                          },
                        );
                      },
                      child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<ProfileAdapter>("user").listenable(),
                          builder: (context, a, child) {
                            return Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorConstants.grey100),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/image 2-2.png"),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(context
                                              .read<EditProfileCubit>()
                                              .currentUser
                                              .phoneNumber !=
                                          null
                                      ? NumberFormat("+#### ### ####").format(
                                          int.parse(
                                              a.get("userData")!.phoneNumber!))
                                      : "N/A"),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).email,
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
                        TextEditingController phoneController =
                            TextEditingController();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              title: Text(S.of(context).changeYourEmail),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () async {
                                      if (!phoneController.text.contains('@') ||
                                          !phoneController.text.contains('.')) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .pleaseProvideAValidEmailAddress),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ));
                                      } else {
                                        final check = await Register.userCheck(
                                            phoneController.text, null);
                                        if (check.emailExists!) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .thisEmailIsAlreadyInUse),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ));
                                        } else {
                                          final code =
                                              await Register.verifyEmail(
                                                  phoneController.text);
                                          Navigator.pop(context);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return ChangePhoneNumberView(
                                                code: code,
                                                email: phoneController.text,
                                              );
                                            },
                                          )).then((value) {
                                            setState(() {});
                                          });
                                        }
                                      }
                                    },
                                    child: Text("OK"))
                              ],
                              contentPadding: EdgeInsets.only(
                                  top: 8, bottom: 8, left: 4, right: 4),
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: AuthInput(
                                  enabled: true,
                                  keyBoardType: TextInputType.emailAddress,
                                  placeholder: S.of(context).email,
                                  controller: phoneController,
                                  repeatController: null,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<ProfileAdapter>("user").listenable(),
                          builder: (context, a, child) {
                            return Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorConstants.grey100),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SvgPicture.asset(
                                      IconConstants.profile_unactive),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(a.get("userData")!.email!),
                                ],
                              ),
                            );
                          }),
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
