import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/post_ad/cubit/post_ad_cubit.dart';
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
                      text: context.read<PostAdCubit>().states),
                  onChanged: (value) {
                    context.read<PostAdCubit>().states = value;
                  },
                  cursorColor: ColorConstants.colorGray,
                  decoration: InputDecoration(
                    hintText: S.of(context).enterYourState,
                    border: InputBorder.none,
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                )),
            SizedBox(height: 20),
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
                      text: context.read<PostAdCubit>().city),
                  onChanged: (value) {
                    context.read<PostAdCubit>().city = value;
                  },
                  cursorColor: ColorConstants.colorGray,
                  decoration: InputDecoration(
                    hintText: S.of(context).enterYourCity,
                    border: InputBorder.none,
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                )),
            SizedBox(height: 20),
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
                    hintText: S.of(context).enterYourCountry,
                    border: InputBorder.none,
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                )),
            SizedBox(height: 20),
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
                  keyboardType: TextInputType.number,
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
