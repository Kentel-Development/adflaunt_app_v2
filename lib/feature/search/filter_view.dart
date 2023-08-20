import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/listing_constants.dart';
import '../../generated/l10n.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedSpaceType;
  String? selectedAdType;
  SfRangeValues sliderVal = SfRangeValues(0.0, 200.0);
  SfRangeValues inchesVal = SfRangeValues(0.0, 100.0);
  DateTime? installationDate;
  DateTime? removalDate;
  String states = '';
  String city = '';
  String country = '';
  String zip = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedSpaceType = null;
                      selectedAdType = null;
                      sliderVal = SfRangeValues(0.0, 200.0);
                      inchesVal = SfRangeValues(0.0, 100.0);
                      installationDate = null;
                      removalDate = null;
                      states = '';
                      city = '';
                      country = '';
                      zip = '';
                    });
                  },
                  child: Text(
                    S.of(context).clearAll,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline),
                  )),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    print(zip);
                    Navigator.pop(context, {
                      'spaceType': selectedSpaceType,
                      'adType': selectedAdType,
                      'price': sliderVal,
                      'inches': inchesVal,
                      'installationDate': installationDate,
                      'removalDate': removalDate,
                      'states': states,
                      'city': city,
                      'country': country,
                      'zip': zip,
                    });
                  },
                  child: Text(
                    S.of(context).apply,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: 'Filter'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).priceRange,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  buildPriceSlider(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 110,
                          height: 50,
                          padding: const EdgeInsets.only(
                              left: 5, right: 16, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent,
                            border: Border.all(
                              color: ColorConstants.colorTertiary,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Minimum \$",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.grey500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '\$${sliderVal.start.toInt()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorConstants.grey300,
                          ),
                          width: 36,
                          height: 2,
                        ),
                        Container(
                          width: 110,
                          height: 50,
                          padding: const EdgeInsets.only(
                              left: 5, right: 16, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent,
                            border: Border.all(
                              color: ColorConstants.colorTertiary,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Maximum \$",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.grey500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '\$${sliderVal.end.toInt()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).spaceSize,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildInchesSlider(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 110,
                          height: 50,
                          padding: const EdgeInsets.only(
                              left: 5, right: 16, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent,
                            border: Border.all(
                              color: ColorConstants.colorTertiary,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Minimum",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.grey500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '${inchesVal.start.toInt()} inches',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorConstants.grey300,
                          ),
                          width: 36,
                          height: 2,
                        ),
                        Container(
                          width: 110,
                          height: 50,
                          padding: const EdgeInsets.only(
                              left: 5, right: 16, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent,
                            border: Border.all(
                              color: ColorConstants.colorTertiary,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Maximum",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.grey500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '${inchesVal.end.toInt()} inches',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).installationDate,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
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
                        initialDate: installationDate == null
                            ? DateTime.now()
                            : installationDate!,
                        firstDate: DateTime(2015, 8),
                        lastDate: removalDate == null
                            ? DateTime(2101)
                            : removalDate!.subtract(Duration(days: 1)),
                      );

                      if (picked != null && picked != installationDate) {
                        setState(() {
                          installationDate = picked;
                        });
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
                          Text(installationDate == null
                              ? "Installation Date"
                              : DateFormat(StringConstants.dateFormat)
                                  .format(installationDate!)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).removalDate,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (installationDate != null) {
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
                                    backgroundColor:
                                        ColorConstants.colorPrimary,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
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
                          initialDate: removalDate == null
                              ? installationDate!.add(const Duration(days: 1))
                              : removalDate!,
                          firstDate:
                              installationDate!.add(const Duration(days: 1)),
                          lastDate: DateTime.now().add(Duration(days: 36500)),
                        );
                        if (picked != null && picked != removalDate) {
                          setState(() {
                            removalDate = picked;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: installationDate == null
                              ? ColorConstants.backgroundColor
                              : Colors.white,
                          border: Border.all(color: ColorConstants.grey100),
                          borderRadius: BorderRadius.circular(4)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconConstants.removal),
                          SizedBox(
                            width: 8,
                          ),
                          Text(removalDate == null
                              ? "Removal Date"
                              : DateFormat(StringConstants.dateFormat)
                                  .format(removalDate!)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).spaceType,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(
                    height: 8,
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
                        value: selectedSpaceType,
                        onChanged: (String? value) {
                          setState(() {
                            selectedSpaceType = value!;
                          });
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
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).adType,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(
                    height: 8,
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
                        value: selectedAdType,
                        onChanged: (String? value) {
                          setState(() {
                            selectedAdType = value!;
                          });
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
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).state,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstants.grey300),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: states),
                        onChanged: (value) {
                          states = value;
                        },
                        cursorColor: ColorConstants.colorGray,
                        decoration: InputDecoration(
                          hintText: S.of(context).state,
                          border: InputBorder.none,
                          alignLabelWithHint: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                      )),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).city,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstants.grey300),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: city),
                        onChanged: (value) {
                          city = value;
                        },
                        cursorColor: ColorConstants.colorGray,
                        decoration: InputDecoration(
                          hintText: S.of(context).city,
                          border: InputBorder.none,
                          alignLabelWithHint: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                      )),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).country,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstants.grey300),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: country),
                        onChanged: (value) {
                          country = value;
                        },
                        cursorColor: ColorConstants.colorGray,
                        decoration: InputDecoration(
                          hintText: S.of(context).country,
                          border: InputBorder.none,
                          alignLabelWithHint: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                      )),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).zipCode,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstants.grey300),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: zip),
                        onChanged: (value) {
                          zip = value;
                        },
                        cursorColor: ColorConstants.colorGray,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: S.of(context).zipCode,
                          border: InputBorder.none,
                          alignLabelWithHint: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SfRangeSliderTheme buildInchesSlider() {
    return SfRangeSliderTheme(
      data: SfRangeSliderThemeData(
        activeTrackHeight: 5,
        activeTrackColor: Colors.black,
        thumbColor: Colors.white,
        thumbStrokeColor: Colors.white,
        tooltipBackgroundColor: ColorConstants.colorTertiary,
        tooltipTextStyle: TextStyle(
          color: ColorConstants.colorPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        inactiveTrackColor: Color.fromRGBO(217, 217, 217, 1),
        activeLabelStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 1,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        inactiveLabelStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 1,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      child: SfRangeSlider(
        stepSize: 1,
        showDividers: false,
        min: 0.0,
        max: 100.0,
        values: inchesVal,
        showLabels: true,
        showTicks: true,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: (values) {
          setState(() {
            inchesVal = values;
          });
        },
        numberFormat: NumberFormat('# inches'),
      ),
    );
  }

  SfRangeSliderTheme buildPriceSlider() {
    return SfRangeSliderTheme(
      data: SfRangeSliderThemeData(
        activeTrackHeight: 5,
        activeTrackColor: Colors.black,
        thumbColor: Colors.white,
        thumbStrokeColor: Colors.white,
        tooltipBackgroundColor: ColorConstants.colorTertiary,
        tooltipTextStyle: TextStyle(
          color: ColorConstants.colorPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        inactiveTrackColor: Color.fromRGBO(217, 217, 217, 1),
        activeLabelStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 1,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        inactiveLabelStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 1,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      child: SfRangeSlider(
        stepSize: 1,
        showDividers: false,
        min: 0.0,
        max: 200.0,
        values: sliderVal,
        showLabels: true,
        showTicks: true,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: (values) {
          setState(() {
            sliderVal = values;
          });
        },
        numberFormat: NumberFormat.simpleCurrency(
          decimalDigits: 0,
          name: '\$',
        ),
      ),
    );
  }
}
