import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/post_ad/about_listing_view.dart';
import 'package:adflaunt/feature/post_ad/ad_details_view.dart';
import 'package:adflaunt/feature/post_ad/ad_posting.dart';
import 'package:adflaunt/feature/post_ad/location_details_view.dart';
import 'package:adflaunt/feature/post_ad/select_on_map_view.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import 'category_tab/category_tab_view.dart';
import 'cubit/post_ad_cubit.dart';

class PostAdView extends StatefulWidget {
  const PostAdView({super.key});

  @override
  State<PostAdView> createState() => _PostAdViewState();
}

class _PostAdViewState extends State<PostAdView>
    with SingleTickerProviderStateMixin {
  int activeStep = 0;
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(
            onLeftIconTap: () {
              if (activeStep > 0) {
                tabController!.animateTo(activeStep - 1);
                setState(() {
                  activeStep--;
                });
              } else {
                Navigator.pop(context);
              }
            },
            hasBackBtn: true,
            title: S.of(context).postAdSpace,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => PostAdCubit()..getLocation(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            EasyStepper(
              activeStep: activeStep,
              lineLength: 60,
              lineSpace: 0,
              disableScroll: true,
              enableStepTapping: false,
              lineType: LineType.normal,
              defaultLineColor: Colors.white,
              finishedLineColor: Colors.black,
              activeLineColor: Colors.black,
              finishedStepBorderType: BorderType.normal,
              activeStepBorderType: BorderType.normal,
              defaultStepBorderType: BorderType.normal,
              unreachedStepBorderType: BorderType.normal,
              unreachedStepBorderColor: ColorConstants.grey200,
              unreachedLineColor: ColorConstants.grey100,
              finishedStepBorderColor: Colors.transparent,
              finishedStepIconColor: Colors.white,
              activeStepTextColor: Colors.black87,
              finishedStepTextColor: Colors.black87,
              borderThickness: 3,
              lineThickness: 1.5,
              internalPadding: 0,
              showLoadingAnimation: false,
              stepRadius: 12,
              activeStepBorderColor: Colors.black,
              showStepBorder: true,
              finishedStepBackgroundColor: Colors.transparent,
              steps: [
                EasyStep(
                  customStep: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    width: 24,
                    height: 24,
                    child: Container(
                      width: 6,
                      height: 6,
                      margin: activeStep > 0
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeStep >= 0
                            ? Colors.black
                            : ColorConstants.grey100,
                      ),
                      child: activeStep > 0
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : Container(),
                    ),
                  ),
                ),
                EasyStep(
                  customStep: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    width: 24,
                    height: 24,
                    child: Container(
                      width: 6,
                      height: 6,
                      margin: activeStep > 1
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeStep >= 1
                            ? Colors.black
                            : ColorConstants.grey100,
                      ),
                      child: activeStep > 1
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : Container(),
                    ),
                  ),
                ),
                EasyStep(
                  customStep: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    width: 24,
                    height: 24,
                    child: Container(
                      width: 6,
                      height: 6,
                      margin: activeStep > 2
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeStep == 0
                            ? Colors.transparent
                            : activeStep >= 2
                                ? Colors.black
                                : ColorConstants.grey100,
                      ),
                      child: activeStep > 2
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : Container(),
                    ),
                  ),
                ),
                EasyStep(
                  customStep: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    width: 24,
                    height: 24,
                    child: Container(
                      width: 6,
                      height: 6,
                      margin: activeStep > 3
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeStep == 0 || activeStep == 1
                            ? Colors.transparent
                            : activeStep >= 3
                                ? Colors.black
                                : ColorConstants.grey100,
                      ),
                      child: activeStep > 3
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : Container(),
                    ),
                  ),
                ),
                EasyStep(
                  customStep: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    width: 24,
                    height: 24,
                    child: Container(
                      width: 6,
                      height: 6,
                      margin: activeStep > 4
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeStep == 0 ||
                                activeStep == 1 ||
                                activeStep == 2
                            ? Colors.transparent
                            : activeStep >= 4
                                ? Colors.black
                                : ColorConstants.grey100,
                      ),
                      child: activeStep > 4
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : Container(),
                    ),
                  ),
                ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
            ),
            Expanded(
              child: DefaultTabController(
                length: 5,
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      CategoryTabView(),
                      SelectLocationTab(),
                      LocationDetailsView(),
                      AdDetailsView(),
                      AboutListingView()
                    ]),
              ),
            ),
            Container(
              height: 100,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              width: double.infinity,
              child: BlocBuilder<PostAdCubit, PostAdState>(
                builder: (context, state) {
                  return SafeArea(
                    child: CommonBtn(
                      text: activeStep == 4
                          ? S.of(context).finish
                          : S.of(context).next,
                      backgroundColor: Colors.black,
                      onPressed: () {
                        if (context.read<PostAdCubit>().verify(activeStep)) {
                          if (activeStep < 4) {
                            tabController!.animateTo(activeStep + 1);
                            setState(() {
                              activeStep++;
                            });
                          } else if (activeStep == 4) {
                            PostAdCubit postAdCubit =
                                context.read<PostAdCubit>();
                            Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                    builder: (context) =>
                                        AdPostingView(value: postAdCubit)));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                S.of(context).pleaseFillAllTheFields,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
