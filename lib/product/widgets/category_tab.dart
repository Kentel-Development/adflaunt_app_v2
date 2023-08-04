import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/l10n.dart';

class CategoryTab extends StatelessWidget {
  CategoryTab({Key? key, this.category = 0, this.isSelected = false})
      : super(key: key);
  final int category;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: Colors.grey[300]!)
                : Border.fromBorderSide(
                    BorderSide(width: 1, color: Colors.transparent))),
        padding: const EdgeInsets.all(PaddingConstants.mediumPadding),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                  category == 0
                      ? IconConstants.indoor
                      : category == 1
                          ? IconConstants.outdoor
                          : IconConstants.vehicle,
                  height: 24,
                  width: 24),
              Text(
                category == 0
                    ? S.of(context).indoorAds
                    : category == 1
                        ? S.of(context).outdoorAds
                        : S.of(context).vehicleAds,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              )
            ],
          ),
        ));
  }
}
