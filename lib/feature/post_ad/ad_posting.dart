import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/feature/post_ad/cubit/post_ad_cubit.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';

class AdPostingView extends StatelessWidget {
  AdPostingView({required this.value, super.key});
  final PostAdCubit value;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostAdCubit>.value(
      value: value..postAd(),
      child: BlocBuilder<PostAdCubit, PostAdState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: ColorConstants.backgroundColor,
              body: Center(
                child: state is PostAdLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoadingWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).postingYourAdPleaseWait,
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Poppins"),
                          ),
                        ],
                      )
                    : state is PostAdSuccess
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(IconConstants.ad_posted),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  S.of(context).adPostedSuccessfully,
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: CommonBtn(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute<dynamic>(
                                          builder: (context) {
                                            return TabView();
                                          },
                                        ), (route) => false);
                                      },
                                      text: S.of(context).goBack,
                                      backgroundColor: Colors.black),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          )
                        : state is PostListingError
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.error,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontFamily: "Poppins"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: CommonBtn(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          text: S.of(context).goBack,
                                          backgroundColor: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
              ),
            ),
          );
        },
      ),
    );
  }
}
