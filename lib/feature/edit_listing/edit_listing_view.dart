import 'dart:developer';
import 'dart:io';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/edit_listing/cubit/edit_listing_cubit.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

/// The above code is importing the 'dart:io' library, which provides classes for working with files,
/// directories, and other input/output operations in Dart.
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../core/constants/icon_constants.dart';
import '../../core/constants/listing_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../generated/l10n.dart';
import '../../product/widgets/category_tab.dart';
import '../../product/widgets/loading_widget.dart';

class EditListingView extends StatefulWidget {
  const EditListingView({required this.listing, super.key});
  final Output listing;
  @override
  State<EditListingView> createState() => _EditListingViewState();
}

class _EditListingViewState extends State<EditListingView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListingCubit(widget.listing)..getImages(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<EditListingCubit, EditListingState>(
          builder: (context, state) {
            return state is EditListingLoading
                ? Container(
                    height: 0,
                  )
                : state is EditListingFailure
                    ? Container(
                        height: 0,
                      )
                    : Container(
                        color: Colors.white,
                        child: SafeArea(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color.fromRGBO(221, 27, 73, 1),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      S.of(context).delete,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    context
                                        .read<EditListingCubit>()
                                        .editListing(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.black,
                                      ),
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          S.of(context).save,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ),
                              )
                            ],
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
            child: Header(hasBackBtn: true, title: S.of(context).editListing),
          ),
        ),
        body: BlocBuilder<EditListingCubit, EditListingState>(
          builder: (context, state) {
            return state is EditListingLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : state is EditListingFailure
                    ? Center(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.of(context).images,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, top: 4, right: 16),
                              child: SizedBox(
                                height: context
                                            .read<EditListingCubit>()
                                            .newImages
                                            .length >
                                        4
                                    ? 160
                                    : 71,
                                child: ReorderableGridView.count(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  onReorder: (oldIndex, newIndex) {
                                    context
                                        .read<EditListingCubit>()
                                        .orderImages(oldIndex, newIndex);
                                  },
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  footer: context
                                              .read<EditListingCubit>()
                                              .newImages
                                              .length ==
                                          10
                                      ? []
                                      : [
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<EditListingCubit>()
                                                  .pickImage();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                    context
                                        .read<EditListingCubit>()
                                        .newImages
                                        .length,
                                    (index) {
                                      return Stack(
                                        key: ValueKey(index),
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              image: DecorationImage(
                                                image: FileImage(
                                                  File(context
                                                      .read<EditListingCubit>()
                                                      .newImages[index]
                                                      .path),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: index != 0
                                                ? Container()
                                                : Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  4),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  4),
                                                        ),
                                                        color: Colors.black,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          S.of(context).primary,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Poppins',
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
                                                    .read<EditListingCubit>()
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
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.of(context).title,
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
                                          text: context
                                              .read<EditListingCubit>()
                                              .title,
                                        ),
                                        onChanged: (value) {
                                          context
                                              .read<EditListingCubit>()
                                              .title = value;
                                        },
                                        cursorColor: ColorConstants.grey300,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(100),
                                        ],
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: S
                                              .of(context)
                                              .giveYourAdSpaceAName,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                              color: ColorConstants.grey300,
                                            ),
                                          ),
                                          focusColor: ColorConstants.grey300,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                              color: ColorConstants.grey300,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                        S.of(context).description,
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
                                      height: 200,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: context
                                              .read<EditListingCubit>()
                                              .description,
                                        ),
                                        onChanged: (value) {
                                          context
                                              .read<EditListingCubit>()
                                              .description = value;
                                        },
                                        cursorColor: ColorConstants.grey300,
                                        maxLines: 10,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                              1000),
                                        ],
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText:
                                              S.of(context).addADescription,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                              color: ColorConstants.grey300,
                                            ),
                                          ),
                                          focusColor: ColorConstants.grey300,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                              color: ColorConstants.grey300,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                              color: ColorConstants.grey300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).priceDetails,
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
                                              text: context
                                                  .read<EditListingCubit>()
                                                  .price,
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<EditListingCubit>()
                                                  .price = value;
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
                                              hintText: S
                                                  .of(context)
                                                  .addPriceHintText,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                              focusColor:
                                                  ColorConstants.grey300,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                          child: TextField(
                                            controller: TextEditingController(
                                              text: context
                                                  .read<EditListingCubit>()
                                                  .height,
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<EditListingCubit>()
                                                  .height = value;
                                            },
                                            cursorColor: ColorConstants.grey300,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d*$')),
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: S.of(context).Inches,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                              focusColor:
                                                  ColorConstants.grey300,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextField(
                                            controller: TextEditingController(
                                              text: context
                                                  .read<EditListingCubit>()
                                                  .width,
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<EditListingCubit>()
                                                  .width = value;
                                            },
                                            cursorColor: const Color.fromARGB(
                                                255, 32, 32, 42),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d*$')),
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: S.of(context).Inches,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                              focusColor:
                                                  ColorConstants.grey300,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: ColorConstants.grey300,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor: ColorConstants
                                                      .colorPrimary,
                                                  value: context
                                                      .read<EditListingCubit>()
                                                      .cancelPolicy,
                                                  onChanged: (value) => context
                                                      .read<EditListingCubit>()
                                                      .changeCancelPolicy()),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 60,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .cancelPolicy,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                  text: " "),
                                                              TextSpan(
                                                                text: S
                                                                    .of(context)
                                                                    .clickHereToReadMore,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: ColorConstants
                                                                      .colorPrimary,
                                                                ),
                                                              ),
                                                            ],
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        buildAdditionalInfos(context),
                                        buildLocationDetails(context),
                                        SizedBox(
                                          height: 32,
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                      );
          },
        ),
      ),
    );
  }

  Column buildLocationDetails(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).state,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(height: 4),
        TextField(
          controller: TextEditingController(
              text: context.read<EditListingCubit>().states),
          onChanged: (value) {
            context.read<EditListingCubit>().states = value;
          },
          cursorColor: ColorConstants.colorGray,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: S.of(context).enterYourState,
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
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).city,
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
        TextField(
          controller: TextEditingController(
              text: context.read<EditListingCubit>().city),
          onChanged: (value) {
            context.read<EditListingCubit>().city = value;
          },
          cursorColor: ColorConstants.colorGray,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: S.of(context).enterYourCity,
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
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).country,
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
        TextField(
          controller: TextEditingController(
              text: context.read<EditListingCubit>().country),
          onChanged: (value) {
            context.read<EditListingCubit>().country = value;
          },
          cursorColor: ColorConstants.colorGray,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: S.of(context).enterYourCountry,
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
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).zipCode,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(height: 4),
        TextField(
          controller:
              TextEditingController(text: context.read<EditListingCubit>().zip),
          onChanged: (value) {
            context.read<EditListingCubit>().zip = value;
          },
          cursorColor: ColorConstants.colorGray,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: S.of(context).enterYourZipCode,
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
      ],
    );
  }

  Column buildAdditionalInfos(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).spaceType,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorConstants.grey300),
              borderRadius: BorderRadius.circular(5)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: false,
              dropdownStyleData: DropdownStyleData(maxHeight: 300),
              hint: Text(
                S.of(context).chooseASpaceType,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),
              items: ListingConstants.spaceType
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins'),
                        ),
                      ))
                  .toList(),
              value: context.watch<EditListingCubit>().selectedSpaceType,
              onChanged: (String? value) {
                context.read<EditListingCubit>().selectSpaceType(value!);
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
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
            S.of(context).adType,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorConstants.grey300),
              borderRadius: BorderRadius.circular(5)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: false,
              dropdownStyleData: DropdownStyleData(maxHeight: 300),
              hint: Text(
                S.of(context).chooseATypeOfAd,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),
              items: ListingConstants.type
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins'),
                        ),
                      ))
                  .toList(),
              value: context.watch<EditListingCubit>().selectedAdType,
              onChanged: (String? value) {
                context.read<EditListingCubit>().selectAdType(value!);
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).installationDate,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
          ),
        ),
        SizedBox(
          height: 4,
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
                        backgroundColor: ColorConstants.colorPrimary,
                        padding: EdgeInsets.symmetric(horizontal: 15),
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
                  context.read<EditListingCubit>().installationDate == null
                      ? DateTime.now()
                      : context.read<EditListingCubit>().installationDate!,
              firstDate: DateTime(2015, 8),
              lastDate: context.read<EditListingCubit>().removalDate == null
                  ? DateTime(2101)
                  : context
                      .read<EditListingCubit>()
                      .removalDate!
                      .subtract(Duration(days: 1)),
            );

            if (picked != null &&
                picked != context.read<EditListingCubit>().installationDate) {
              context.read<EditListingCubit>().changeInstallationDate(picked);
            }
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorConstants.grey100),
                borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(IconConstants.installation),
                SizedBox(
                  width: 8,
                ),
                Text(context.read<EditListingCubit>().installationDate == null
                    ? "Installation Date"
                    : DateFormat(StringConstants.dateFormat).format(
                        context.read<EditListingCubit>().installationDate!)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).removalDate,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () async {
            if (context.read<EditListingCubit>().installationDate != null) {
              final DateTime? picked = await showDatePicker(
                context: context,
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
                          backgroundColor: ColorConstants.colorPrimary,
                          padding: EdgeInsets.symmetric(horizontal: 15),
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
                initialDate:
                    context.read<EditListingCubit>().removalDate == null
                        ? context
                            .read<EditListingCubit>()
                            .installationDate!
                            .add(const Duration(days: 1))
                        : context.read<EditListingCubit>().removalDate!,
                firstDate: context
                    .read<EditListingCubit>()
                    .installationDate!
                    .add(const Duration(days: 1)),
                lastDate: DateTime.now().add(Duration(days: 36500)),
              );
              if (picked != null &&
                  picked != context.read<EditListingCubit>().removalDate) {
                context.read<EditListingCubit>().changeRemovalDate(picked);
              }
            }
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                color: context.read<EditListingCubit>().installationDate == null
                    ? ColorConstants.backgroundColor
                    : Colors.white,
                border: Border.all(color: ColorConstants.grey100),
                borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(IconConstants.removal),
                SizedBox(
                  width: 8,
                ),
                Text(context.read<EditListingCubit>().removalDate == null
                    ? "Removal Date"
                    : DateFormat(StringConstants.dateFormat)
                        .format(context.read<EditListingCubit>().removalDate!)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Tags",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                  children: [
                    TextSpan(
                      text: " " + "(Optional)",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: ColorConstants.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                controller: context.read<EditListingCubit>().tagsController,
                cursorColor: ColorConstants.colorPrimary,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.grey300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.grey300, width: 1),
                  ),
                  hintText: 'Enter tags',
                ),
                onSubmitted: (value) async {
                  log(value);
                  if (context.read<EditListingCubit>().tags.contains(value) ==
                      false) {
                    if (ListingConstants.type.contains(value) == false &&
                        ListingConstants.spaceType.contains(value) == false) {
                      context.read<EditListingCubit>().addTag(value);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S
                              .of(context)
                              .pleaseEnterADifferentTagNameThisIsTypeName),
                        ),
                      );
                    }
                  }
                  context.read<EditListingCubit>().tagsController.clear();
                },
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: context.read<EditListingCubit>().tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () {
                      context.read<EditListingCubit>().removeTag(tag);
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: PaddingConstants.mediumPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.read<EditListingCubit>().changeCategory(1);
                        },
                        child: CategoryTab(
                            category: 0,
                            isSelected: context
                                    .read<EditListingCubit>()
                                    .selectedCategory ==
                                1)),
                    GestureDetector(
                      onTap: () {
                        context.read<EditListingCubit>().changeCategory(0);
                      },
                      child: CategoryTab(
                        category: 1,
                        isSelected:
                            context.read<EditListingCubit>().selectedCategory ==
                                0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<EditListingCubit>().changeCategory(2);
                      },
                      child: CategoryTab(
                        category: 2,
                        isSelected:
                            context.read<EditListingCubit>().selectedCategory ==
                                2,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
