import 'dart:developer';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/listing_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/post_ad/cubit/post_ad_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

class AdDetailsView extends StatelessWidget {
  const AdDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).giveUsYourAdDetails,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 20,
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
              BlocBuilder<PostAdCubit, PostAdState>(
                builder: (context, state) {
                  return Container(
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
                        value: context.watch<PostAdCubit>().selectedSpaceType,
                        onChanged: (String? value) {
                          context.read<PostAdCubit>().selectSpaceType(value!);
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
                  );
                },
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
              BlocBuilder<PostAdCubit, PostAdState>(
                builder: (context, state) {
                  return Container(
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
                        value: context.watch<PostAdCubit>().selectedAdType,
                        onChanged: (String? value) {
                          context.read<PostAdCubit>().selectAdType(value!);
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
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).available,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              BlocBuilder<PostAdCubit, PostAdState>(
                builder: (context, state) {
                  return GestureDetector(
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
                            context.read<PostAdCubit>().installationDate == null
                                ? DateTime.now()
                                : context.read<PostAdCubit>().installationDate!,
                        firstDate: DateTime(2015, 8),
                        lastDate:
                            context.read<PostAdCubit>().removalDate == null
                                ? DateTime(2101)
                                : context
                                    .read<PostAdCubit>()
                                    .removalDate!
                                    .subtract(Duration(days: 1)),
                      );

                      if (picked != null &&
                          picked !=
                              context.read<PostAdCubit>().installationDate) {
                        context
                            .read<PostAdCubit>()
                            .changeInstallationDate(picked);
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
                          Text(context.read<PostAdCubit>().installationDate ==
                                  null
                              ? "Installation Date"
                              : DateFormat(StringConstants.dateFormat).format(
                                  context
                                      .read<PostAdCubit>()
                                      .installationDate!)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).until,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              BlocBuilder<PostAdCubit, PostAdState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    if (context.read<PostAdCubit>().installationDate != null) {
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
                            context.read<PostAdCubit>().removalDate == null
                                ? context
                                    .read<PostAdCubit>()
                                    .installationDate!
                                    .add(const Duration(days: 1))
                                : context.read<PostAdCubit>().removalDate!,
                        firstDate: context
                            .read<PostAdCubit>()
                            .installationDate!
                            .add(const Duration(days: 1)),
                        lastDate: DateTime.now().add(Duration(days: 36500)),
                      );
                      if (picked != null &&
                          picked != context.read<PostAdCubit>().removalDate) {
                        context.read<PostAdCubit>().changeRemovalDate(picked);
                      }
                    }
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color:
                            context.read<PostAdCubit>().installationDate == null
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
                        Text(context.read<PostAdCubit>().removalDate == null
                            ? "Removal Date"
                            : DateFormat(StringConstants.dateFormat).format(
                                context.read<PostAdCubit>().removalDate!)),
                      ],
                    ),
                  ),
                );
              }),
              BlocBuilder<PostAdCubit, PostAdState>(
                builder: (context, state) {
                  return Padding(
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
                          controller:
                              context.read<PostAdCubit>().tagsController,
                          cursorColor: ColorConstants.colorPrimary,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.grey300, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.grey300, width: 1),
                            ),
                            hintText: 'Enter tags',
                          ),
                          onSubmitted: (value) async {
                            log(value);
                            if (context
                                    .read<PostAdCubit>()
                                    .tags
                                    .contains(value) ==
                                false) {
                              if (ListingConstants.type.contains(value) ==
                                      false &&
                                  ListingConstants.spaceType.contains(value) ==
                                      false) {
                                context.read<PostAdCubit>().addTag(value);
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
                            context.read<PostAdCubit>().tagsController.clear();
                          },
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: context.read<PostAdCubit>().tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              onDeleted: () {
                                context.read<PostAdCubit>().removeTag(tag);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
