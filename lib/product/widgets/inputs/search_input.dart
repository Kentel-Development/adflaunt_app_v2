import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/feature/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        onSubmitted: (value) {
          Navigator.push(context,
              MaterialPageRoute<dynamic>(builder: (context) {
            return SearchView();
          }));
        },
        cursorColor: ColorConstants.colorTertiary,
        style: TextStyle(
            color: ColorConstants.colorTertiary,
            fontSize: 12,
            fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: S.of(context).enterLocation,
          prefixIcon: SvgPicture.asset(
            IconConstants.search,
            // ignore: deprecated_member_use
            color: ColorConstants.colorTertiary,
            fit: BoxFit.scaleDown,
          ),
          fillColor: ColorConstants.colorSecondary,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
