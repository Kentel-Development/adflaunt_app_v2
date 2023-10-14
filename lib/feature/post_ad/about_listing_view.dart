import 'dart:io';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/feature/post_ad/cubit/post_ad_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../generated/l10n.dart';

class AboutListingView extends StatelessWidget {
  const AboutListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).youreAlmostThere,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).justAFewMoreDetailsLeft,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).aboutAdSpace,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            BlocBuilder<PostAdCubit, PostAdState>(
              builder: (context, state) {
                return context.read<PostAdCubit>().images.length > 0
                    ? SizedBox(
                        height: context.read<PostAdCubit>().images.length > 4
                            ? 160
                            : 71,
                        child: ReorderableGridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          onReorder: (oldIndex, newIndex) {
                            context
                                .read<PostAdCubit>()
                                .orderImages(oldIndex, newIndex);
                          },
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          footer: context.read<PostAdCubit>().images.length ==
                                  10
                              ? []
                              : [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<PostAdCubit>().pickImage();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: ColorConstants.grey2000,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          IconConstants.add_bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                          children: List.generate(
                            context.read<PostAdCubit>().images.length,
                            (index) {
                              return Stack(
                                key: ValueKey(index),
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(context
                                              .read<PostAdCubit>()
                                              .images[index]
                                              .path),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: index != 0
                                        ? Container()
                                        : Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 20,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4),
                                                ),
                                                color: Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Primary",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<PostAdCubit>()
                                            .removeImage(index);
                                      },
                                      child: Container(
                                        child: Center(
                                          child: SvgPicture.asset(
                                            IconConstants.close,
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).uploadPhotos,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<PostAdCubit>().pickImage();
                            },
                            child: Container(
                              height: 66,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: ColorConstants.grey300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(IconConstants.add),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    S.of(context).addPhotos,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<PostAdCubit>().takeImage();
                            },
                            child: Container(
                              height: 66,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: ColorConstants.grey300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(IconConstants.add_camera),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    S.of(context).takeNewPhotos,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).addYourPricePerDay,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: TextEditingController(
                  text: context.read<PostAdCubit>().price,
                ),
                onChanged: (value) {
                  context.read<PostAdCubit>().price = value;
                },
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'en_US',
                    customPattern: '\u00A4#.###',
                    symbol: '\$',
                  ),
                ],
                keyboardType: TextInputType.number,
                cursorColor: ColorConstants.grey300,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: S.of(context).addPriceHintText,
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
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).addATitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: TextEditingController(
                  text: context.read<PostAdCubit>().title,
                ),
                onChanged: (value) {
                  context.read<PostAdCubit>().title = value;
                },
                cursorColor: ColorConstants.grey300,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: S.of(context).giveYourAdSpaceAName,
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
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).addADescription,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 130,
              child: TextField(
                controller: TextEditingController(
                  text: context.read<PostAdCubit>().description,
                ),
                onChanged: (value) {
                  context.read<PostAdCubit>().description = value;
                },
                cursorColor: ColorConstants.grey300,
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText:
                      S.of(context).youCanWriteInformationAboutThisAdSpace,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).sizeOfAd,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(
                        text: context.read<PostAdCubit>().height,
                      ),
                      onChanged: (value) {
                        context.read<PostAdCubit>().height = value;
                      },
                      cursorColor: ColorConstants.grey300,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$')),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: S.of(context).Inches,
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
                    width: 4,
                  ),
                  Text("X",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: ColorConstants.grey300)),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(
                        text: context.read<PostAdCubit>().width,
                      ),
                      onChanged: (value) {
                        context.read<PostAdCubit>().width = value;
                      },
                      cursorColor: ColorConstants.grey300,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$')),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: S.of(context).Inches,
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
                ],
              ),
            ),
            SizedBox(
              height: 27,
            ),
            BlocBuilder<PostAdCubit, PostAdState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Checkbox(
                        checkColor: Colors.white,
                        activeColor: ColorConstants.colorPrimary,
                        value: context.read<PostAdCubit>().cancelPolicy,
                        onChanged: (value) =>
                            context.read<PostAdCubit>().changeCancelPolicy()),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).cancelPolicy,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: S
                                          .of(context)
                                          .byClickingTheFinishButtonYouAcceptTheTermsOf,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    TextSpan(text: " "),
                                    TextSpan(
                                      text: S.of(context).clickHereToReadMore,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Poppins',
                                        color: ColorConstants.colorPrimary,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
