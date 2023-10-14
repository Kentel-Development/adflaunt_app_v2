import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/post_ad/cubit/post_ad_cubit.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';

class LocationDetailsView extends StatelessWidget {
  const LocationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onVerticalDragStart: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).giveUsLocationDetailsToFindYourAdEasily,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 20),
            CSCPicker(
              disableCountry: true,
              layout: Layout.vertical,
              dropdownButtonHeight: 55,
              hideCountry: true,
              flagState: CountryFlag.DISABLE,
              currentCountry: "United States",
              currentCity: context.read<PostAdCubit>().city == ""
                  ? null
                  : context.read<PostAdCubit>().city,
              currentState: context.read<PostAdCubit>().states == ""
                  ? null
                  : context.read<PostAdCubit>().states,
              dropdownDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              disabledDropdownDecoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              onStateChanged: (value) {
                if (value != null) {
                  context.read<PostAdCubit>().states = value.toString();
                }
              },
              onCityChanged: (value) {
                if (value != null) {
                  context.read<PostAdCubit>().city = value.toString();
                }
              },
            ),
            SizedBox(height: 10),
            Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  controller: TextEditingController(
                      text: context.read<PostAdCubit>().country),
                  onChanged: (value) {
                    context.read<PostAdCubit>().country = value;
                  },
                  cursorColor: ColorConstants.colorGray,
                  decoration: InputDecoration(
                    hintText: S.of(context).enterYourCrossStreet,
                    border: InputBorder.none,
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                )),
            SizedBox(height: 10),
            Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  controller: TextEditingController(
                      text: context.read<PostAdCubit>().zip),
                  onChanged: (value) {
                    context.read<PostAdCubit>().zip = value;
                  },
                  cursorColor: ColorConstants.colorGray,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: S.of(context).enterYourZipCode,
                    border: InputBorder.none,
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
