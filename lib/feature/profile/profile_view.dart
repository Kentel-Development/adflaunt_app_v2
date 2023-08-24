// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/balance/balance_view.dart';
import 'package:adflaunt/feature/my_listings/my_listings_view.dart';
import 'package:adflaunt/feature/payment_method/payment_method_view.dart';
import 'package:adflaunt/feature/profile/edit_profile_view.dart';
import 'package:adflaunt/feature/verify_id/verify_id_view.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/main.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/services/login.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:adflaunt/product/widgets/verify_badge.dart';
import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../post_ad/post_ad_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({this.isFromDrawer = false, super.key});
  final bool isFromDrawer;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final userData = Hive.box<ProfileAdapter>("user").get("userData")!;
    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Header(
                hasBackBtn: !widget.isFromDrawer, title: S.of(context).profile),
          ),
        ),
        body: FutureBuilder(
            future:
                LoginAPI.login(userData.email!, userData.password!, null, null),
            builder: (context, user) {
              if (user.connectionState == ConnectionState.done &&
                  user.hasData) {
                final userModel = ProfileModel.fromJson(
                    jsonDecode(user.data!.body) as Map<String, dynamic>);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 55,
                      ),
                      ValueListenableBuilder(
                          valueListenable:
                              Hive.box<ProfileAdapter>('user').listenable(),
                          builder: (context, Box<ProfileAdapter> box, child) {
                            final userData = box.get('userData')!;
                            return Column(
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      userData.profileImage != null &&
                                              userData.profileImage != ''
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8, right: 8),
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  StringConstants
                                                          .baseStorageUrl +
                                                      userData.profileImage!
                                                          .toString(),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8, right: 8),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[300],
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
                                            Navigator.push(context,
                                                MaterialPageRoute<dynamic>(
                                              builder: (context) {
                                                return EditProfileView(
                                                    userModel: userModel);
                                              },
                                            ));
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                IconConstants.container,
                                              ),
                                              Image.asset(
                                                  IconConstants.edit_line),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: Text(
                                    userData.fullName!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute<dynamic>(
                                  builder: (context) {
                                    return MyListingsView();
                                  },
                                ));
                              },
                              leading: SvgPicture.asset(
                                IconConstants.list_profile,
                                color: Colors.black,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              title: Text(
                                S.of(context).myAdSpaces,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                IconConstants.post_ad,
                                color: Colors.black,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              onTap: () {
                                if (userModel.idVerified) {
                                  Navigator.push(context,
                                      MaterialPageRoute<dynamic>(
                                    builder: (context) {
                                      return PostAdView();
                                    },
                                  ));
                                } else {
                                  showDialog<dynamic>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(S
                                            .of(context)
                                            .pleaseVerifyYourIdToPostAnAd),
                                        actions: [
                                          TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(S.of(context).ok))
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              title: Text(
                                S.of(context).postAdSpace,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                if (!(userModel.idVerified)) {
                                  Navigator.push(context,
                                      MaterialPageRoute<dynamic>(
                                    builder: (context) {
                                      return const VerifyIDView();
                                    },
                                  )).then((value) => setState(() {}));
                                }
                              },
                              leading: SvgPicture.asset(
                                IconConstants.verify,
                                color: Colors.black,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              title: Row(
                                children: [
                                  Text(
                                    S.of(context).verifyYourId,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  VerifyBadge(isVerified: userModel.idVerified),
                                ],
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute<dynamic>(
                                  builder: (context) {
                                    return const PaymentMethodView();
                                  },
                                ));
                              },
                              leading: SvgPicture.asset(
                                IconConstants.payment_method,
                                color: Colors.black,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              title: Text(
                                S.of(context).paymentMethod,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute<dynamic>(
                                  builder: (context) {
                                    return const BalanceView();
                                  },
                                ));
                              },
                              leading: SvgPicture.asset(
                                IconConstants.bank,
                                color: Colors.black,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              title: Text(
                                S.of(context).balance,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                AppSettings.openAppSettings();
                              },
                              leading: SvgPicture.asset(
                                IconConstants.language,
                                color: Colors.black,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              title: Text(
                                S.of(context).language,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                LoginAPI.logout();
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute<dynamic>(
                                  builder: (context) {
                                    return MainApp();
                                  },
                                ), (route) => false);
                              },
                              leading: SvgPicture.asset(
                                IconConstants.logout,
                                height: 24,
                                width: 24,
                              ),
                              horizontalTitleGap: 0,
                              title: Text(
                                S.of(context).logout,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(221, 27, 73, 1),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              trailing: SvgPicture.asset(
                                IconConstants.arrow_right,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: LoadingWidget(),
                );
              }
            }));
  }
}
