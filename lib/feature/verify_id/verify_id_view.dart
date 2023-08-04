import 'dart:io';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/feature/verify_id/camera_view.dart';
import 'package:adflaunt/feature/verify_id/cubit/verify_id_cubit.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/l10n.dart';

class VerifyIDView extends StatefulWidget {
  const VerifyIDView({super.key});

  @override
  State<VerifyIDView> createState() => _VerifyIDViewState();
}

class _VerifyIDViewState extends State<VerifyIDView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(
              hasBackBtn: true, title: S.of(context).identityVerification),
        ),
      ),
      body: BlocProvider<VerifyIdCubit>(
        create: (context) => VerifyIdCubit(),
        child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                buildShippingAddressTab(context),
                Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 45,
                            ),
                            Text(
                              S.of(context).takeAPictureOfId,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              S.of(context).takeAPictureOfTheFrontAndBackOfYour,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SvgPicture.asset(IconConstants.id_card),
                        Column(
                          children: [
                            SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: BlocConsumer<VerifyIdCubit, VerifyIdState>(
                                  listener: (context, state) {
                                if (state is VerifyIdSuccess) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        S
                                            .of(context)
                                            .yourIdHasBeenVerifiedSuccessfully,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else if (state is VerifyIdFailure) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        state.message,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }, builder: (context, state) {
                                return CommonBtn(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute<dynamic>(
                                        builder: (context) {
                                          return CameraView();
                                        },
                                      )).then((value) {
                                        if (value != null) {
                                          context
                                              .read<VerifyIdCubit>()
                                              .verifyId((value[0] as File),
                                                  (value[1] as File));
                                          // ignore: inference_failure_on_function_invocation
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Uploading..."),
                                                  content: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        LoadingWidget()
                                                      ]),
                                                );
                                              });
                                        }
                                      });
                                    },
                                    text: S.of(context).takePicture,
                                    backgroundColor: Colors.black);
                              }),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: ColorConstants.grey2000),
                              child: Row(
                                children: [
                                  SvgPicture.asset(IconConstants.lock),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      S
                                          .of(context)
                                          .theDataYouShareWillBeEncryptedStoredSecurelyAnd,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(38, 38, 38, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildShippingAddressTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).addYourShippingAddress,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          BlocBuilder<VerifyIdCubit, VerifyIdState>(
            builder: (context, state) {
              return TextField(
                controller: BlocProvider.of<VerifyIdCubit>(context)
                    .shippingAddressController,
                maxLines: 7,
                cursorColor: ColorConstants.grey300,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: S.of(context).enterShippingAddress,
                  contentPadding: EdgeInsets.all(12),
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
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: BlocBuilder<VerifyIdCubit, VerifyIdState>(
                builder: (context, state) {
                  return CommonBtn(
                    onPressed: () {
                      if (BlocProvider.of<VerifyIdCubit>(context)
                          .shippingAddressController
                          .text
                          .isNotEmpty) {
                        if (BlocProvider.of<VerifyIdCubit>(context)
                                .shippingAddressController
                                .text
                                .length >
                            10) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          tabController!.animateTo(1);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                S.of(context).pleaseEnterValidAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).pleaseEnterYourShippingAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    text: S.of(context).next,
                    backgroundColor: Colors.black,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
