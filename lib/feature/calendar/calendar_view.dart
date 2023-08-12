import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/calendar/listing_calendar_view.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: 'Calendar'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: FutureBuilder(
            future: ListingsAPI.getUserListings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute<dynamic>(
                          builder: (context) {
                            return ListingCalendarView(
                                listing: snapshot.data![index]);
                          },
                        ));
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 4),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        snapshot.data![index].tags[0],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].tags[1],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.grey500,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: StringConstants.baseStorageUrl +
                                    snapshot.data![index].images[0],
                                fit: BoxFit.cover,
                              ),
                            ))
                          ],
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 16),
                        height: 90,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.grey300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: LoadingWidget());
              }
            }),
      ),
    );
  }
}
