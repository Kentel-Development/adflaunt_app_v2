import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/core/extensions/date_parser_extension.dart';
import 'package:adflaunt/feature/booking_list/host_page.dart';
import 'package:adflaunt/product/models/bookings_with_profile_images.dart';
import 'package:adflaunt/product/models/listings/results.dart' as results;
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';

class ListingCalendarView extends StatelessWidget {
  const ListingCalendarView({required this.listing, super.key});
  final results.Output listing;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Header(hasBackBtn: true, title: listing.title),
          ),
        ),
        body: FutureBuilder(
            future: BookingService.getBookingsWithProfileImages(listing.id!),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: LoadingWidget(),
                    )
                  : PagedVerticalCalendar(
                      minDate: listing.checkIn.parseDate(),
                      maxDate: listing.checkOut.parseDate(),
                      dayBuilder: (context, date) {
                        bool isBetween;
                        bool isStart = snapshot.data!.output!.any((element) {
                          return element.daysWantToBook!.first.toString() ==
                              date.toString();
                        });
                        bool isStartAndLast =
                            snapshot.data!.output!.any((element) {
                          return element.daysWantToBook!.first.toString() ==
                                  date.toString() &&
                              element.daysWantToBook!.last.toString() ==
                                  date.toString();
                        });
                        Output? getBookingData(DateTime date) {
                          return snapshot.data?.output?.firstWhere(
                            (element) =>
                                element.daysWantToBook!.first.isSameDay(date),
                            orElse: () => Output(),
                          );
                        }

                        String? image =
                            getBookingData(date)?.profileImage as String?;
                        String? bookingId = getBookingData(date)?.bookingID;
                        bool isEnd = snapshot.data!.output!.any((element) {
                          return element.daysWantToBook!.last.toString() ==
                              date.toString();
                        });
                        if (snapshot.data!.output!.any((element) {
                          return element.daysWantToBook!.toString().contains(
                              date
                                  .toString()
                                  .substring(0, date.toString().length - 1));
                        })) {
                          isBetween = true;
                        } else {
                          isBetween = false;
                        }
                        return isStartAndLast
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute<dynamic>(
                                    builder: (context) {
                                      return HostPage(
                                        null,
                                        bookingId!,
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                    alignment: isStart
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      child: Center(
                                        child: !isStart
                                            ? Text(
                                                date.day.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : image == null
                                                ? Icon(Icons.person)
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1000),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: StringConstants
                                                                  .baseStorageUrl +
                                                              image,
                                                          fit: BoxFit.cover,
                                                          width:
                                                              size.width * 0.1,
                                                          height: size.height *
                                                              0.04,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                      height: size.height * 0.04,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    )),
                              )
                            : isStart || isEnd
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute<dynamic>(
                                        builder: (context) {
                                          return HostPage(
                                            null,
                                            bookingId!,
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                        alignment: isStart
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: isStart ? 20 : 0,
                                            right: isStart ? 0 : 20),
                                        child: Container(
                                          child: Center(
                                            child: !isStart
                                                ? Text(
                                                    date.day.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : image == null
                                                    ? Icon(Icons.person)
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1000),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  StringConstants
                                                                          .baseStorageUrl +
                                                                      image,
                                                              fit: BoxFit.cover,
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              height:
                                                                  size.height *
                                                                      0.04,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                          ),
                                          height: size.height * 0.04,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  color: Colors.black,
                                                  width: isStart ? 0 : 1),
                                              left: BorderSide(
                                                  color: Colors.black,
                                                  width: isStart ? 1 : 0),
                                              top: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                            ),
                                            borderRadius: isStart
                                                ? BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  )
                                                : BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                          ),
                                        )),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Container(
                                      height: size.height * 0.04,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: isBetween
                                              ? Border(
                                                  right: BorderSide(
                                                      color: Colors.black,
                                                      width: 0),
                                                  left: BorderSide(
                                                      color: Colors.black,
                                                      width: 0),
                                                  top: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                )
                                              : Border()),
                                      child: Center(
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                      },
                    );
            }));
  }
}
