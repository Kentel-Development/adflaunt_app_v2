import 'dart:io';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/extensions/date_parser_extension.dart';
import 'package:adflaunt/feature/booking/mixin/booking_mixin.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/models/unavailable_dates_model.dart';
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../core/constants/icon_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../generated/l10n.dart';
import '../../product/widgets/listing/ad_specs.dart';

class BookingView extends StatefulWidget {
  const BookingView({required this.listing, super.key});
  final Output listing;
  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> with BookingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        color: Colors.white,
        child: SafeArea(
            child: Row(
          children: [
            Expanded(
                child: CommonBtn(
              onPressed: confirmAndPay,
              text: S.of(context).confirmAndPay,
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ))
          ],
        )),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: S.of(context).booking),
        ),
      ),
      body: FutureBuilder(
          future: BookingService.getBookedDates(widget.listing.id!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingWidget(),
              );
            } else {
              printFee = snapshot.data!.printFee;
              unavailableDates = snapshot.data!.output!;
              List<DateTime> bookedDates = [];
              if (snapshot.data!.output != null) {
                snapshot.data!.output!.forEach((element) {
                  bookedDates.add(element.parseBookingDate());
                });
              }
              return ListView(
                children: [
                  buildImageView(context),
                  SizedBox(
                    height: 16,
                  ),
                  pageIndicator(),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.listing.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.listing.location,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstants.grey500,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(IconConstants.star),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.listing.averageRating.toString() +
                                        "(" +
                                        widget.listing.numberOfReviews
                                            .toString() +
                                        ")",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstants.grey500,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).adSpecs,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          AdSpecs(adSpecs: adSpecs),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).dates,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          datePicker(bookedDates),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).files,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S
                                  .of(context)
                                  .uploadYourProjectFilesNowOrChooseToUploadThem,
                              style: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          file(),
                          SizedBox(
                            height: files.length > 0 ? 20 : 0,
                          ),
                          filePicker(context),
                          SizedBox(
                            height: 20,
                          ),
                          paymentMethodSelection(context),
                          SizedBox(
                            height: 16,
                          ),
                          priceDetails(context, snapshot),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      )),
                ],
              );
            }
          }),
    );
  }

  Column priceDetails(
      BuildContext context, AsyncSnapshot<UnavailableDatesModel> snapshot) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).priceDetails,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$" + widget.listing.price.toStringAsFixed(2) + "/day",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(161, 161, 170, 1)),
            ),
            Text(
              "\$" + (widget.listing.price * bookedDays).toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(161, 161, 170, 1)),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              S.of(context).serviceFee,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(161, 161, 170, 1)),
            ),
            Spacer(),
            Text(
              "\$${snapshot.data!.printFee!.toDouble()}",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(161, 161, 170, 1)),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              "Total",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            Spacer(),
            Text(
              "\$${(widget.listing.price * bookedDays) + snapshot.data!.printFee!.toDouble()}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        )
      ],
    );
  }

  Column paymentMethodSelection(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).paymentMethod,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        paymentMethods == null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              )
            : Column(
                children: List.generate(
                    paymentMethods!.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPaymentMethod = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedPaymentMethod == index
                                      ? Colors.black
                                      : ColorConstants.grey300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    paymentMethods![index]["card"]["brand"]
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "**** **** **** " +
                                        paymentMethods![index]["card"]["last4"]
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                  ),
                                  Spacer(),
                                  selectedPaymentMethod == index
                                      ? SvgPicture.asset(
                                          IconConstants.check_ring,
                                          // ignore: deprecated_member_use
                                          color: Colors.black,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedPaymentMethod = null;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedPaymentMethod == null
                      ? Colors.black
                      : ColorConstants.grey300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(Platform.isAndroid
                      ? IconConstants.google
                      : IconConstants.apple),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    Platform.isAndroid
                        ? S.of(context).continueWithGooglePay
                        : S.of(context).continueWithApplePay,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  ),
                  Spacer(),
                  selectedPaymentMethod == null
                      ? SvgPicture.asset(
                          IconConstants.check_ring,
                          // ignore: deprecated_member_use
                          color: Colors.black,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 45,
          child: GestureDetector(
            onTap: addCard,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstants.grey300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(IconConstants.add),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    S.of(context).addPaymentMethod,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row filePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              pickFile();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorConstants.grey300,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconConstants.upload_file),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    S.of(context).uploadFile,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              pickImage();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorConstants.grey300,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconConstants.upload_image),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    S.of(context).uploadImages,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column file() {
    return Column(
      children: files.map((e) {
        return ListTile(
          title: Text(
            e.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                files.remove(e);
              });
            },
            child: Icon(Icons.delete, color: Colors.red),
          ),
        );
      }).toList(),
    );
  }

  Column datePicker(List<DateTime> snapshot) {
    return Column(
      children: [
        Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorConstants.grey300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).available,
                    style: TextStyle(
                      color: Color.fromRGBO(161, 161, 161, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy')
                        .format(widget.listing.checkIn.parseDate()),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: VerticalDivider(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).until,
                    style: TextStyle(
                      color: Color.fromRGBO(161, 161, 161, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy')
                        .format(widget.listing.checkOut.parseDate()),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorConstants.grey300,
            ),
          ),
          child: SfDateRangePicker(
            minDate: widget.listing.tags[1] != "Digital"
                ? DateTime.now().add(Duration(days: 5))
                : DateTime.now().add(Duration(days: 1)),
            maxDate: widget.listing.checkOut.parseDate(),
            todayHighlightColor: Colors.black,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs
                dateRangePickerSelectionChangedArgs) {
              setState(() {});
            },
            monthCellStyle: DateRangePickerMonthCellStyle(
              disabledDatesDecoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: ColorConstants.grey300,
                ),
              ),
              disabledDatesTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
              blackoutDatesDecoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: ColorConstants.grey300,
                ),
              ),
            ),
            selectableDayPredicate: (date) {
              bool isBooked = snapshot.contains(date);
              bool isAfter = date.isAfter(widget.listing.checkOut.parseDate());
              bool isBefore = widget.listing.tags[1] != "Digital"
                  ? date.isBefore(DateTime.now().add(Duration(days: 5)))
                  : date.isBefore(DateTime.now());
              bool isUnavailable = isBooked || isAfter || isBefore;
              return !isUnavailable;
            },
            controller: datePickerController,
            selectionMode: DateRangePickerSelectionMode.range,
            rangeSelectionColor: ColorConstants.grey300,
            endRangeSelectionColor: Colors.black,
            startRangeSelectionColor: Colors.black,
            rangeTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
            cellBuilder: (context, cellDetails) {
              bool isBooked = snapshot.contains(cellDetails.date);
              bool isAfter =
                  cellDetails.date.isAfter(widget.listing.checkOut.parseDate());
              bool isBefore = widget.listing.tags[1] != "Digital"
                  ? cellDetails.date
                      .isBefore(DateTime.now().add(Duration(days: 5)))
                  : cellDetails.date.isBefore(DateTime.now());
              bool isUnavailable = isBooked || isAfter || isBefore;
              bool isRangeStart = datePickerController.selectedRange == null
                  ? false
                  : (cellDetails.date ==
                      datePickerController.selectedRange!.startDate);
              bool isRangeEnd = datePickerController.selectedRange == null
                  ? false
                  : cellDetails.date ==
                      datePickerController.selectedRange!.endDate;
              bool isRange = isRangeStart || isRangeEnd;
              bool isRangeMiddle = datePickerController.selectedRange == null
                  ? false
                  : datePickerController.selectedRange!.endDate == null
                      ? false
                      : (cellDetails.date.isAfter(
                              datePickerController.selectedRange!.startDate!) &&
                          cellDetails.date.isBefore(
                              datePickerController.selectedRange!.endDate!));
              return Container(
                  decoration: BoxDecoration(
                    color: isRangeMiddle
                        ? ColorConstants.rangeCell
                        : isRange
                            ? ColorConstants.selectedCell
                            : isUnavailable
                                ? ColorConstants.unavailableCell
                                : Colors.white,
                    border: Border.all(
                      color: ColorConstants.grey300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      cellDetails.date.day.toString(),
                      style: TextStyle(
                        color: isRange ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ));
            },
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                color: ColorConstants.grey500,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
            view: DateRangePickerView.month,
            showNavigationArrow: true,
            navigationDirection: DateRangePickerNavigationDirection.horizontal,
            enablePastDates: false,
            allowViewNavigation: false,
          ),
        ),
      ],
    );
  }

  Padding pageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 8,
        child: PageViewDotIndicator(
          currentItem: selectedPage,
          count: widget.listing.images.length,
          unselectedColor: Color.fromRGBO(217, 217, 217, 1),
          selectedColor: Colors.black,
          duration: Duration(milliseconds: 200),
          boxShape: BoxShape.rectangle,
          size: Size.fromWidth(14),
          unselectedSize: Size.fromWidth(8),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Stack buildImageView(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 240,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: onPageChanged,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.listing.images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: StringConstants.baseStorageUrl +
                    widget.listing.images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
            bottom: 18,
            right: 25,
            child: GestureDetector(
              onTap: onChatTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(IconConstants.chat),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      S.of(context).chat,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
