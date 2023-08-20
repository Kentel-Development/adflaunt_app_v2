import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/services/reviews.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../core/constants/icon_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../product/widgets/headers/main_header.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({required this.listingId, super.key});
  final String listingId;
  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: S.of(context).reviews),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: FutureBuilder(
          future: ReviewService.getReviews(widget.listingId),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              List<Review> reviews = [];
              snapshot.data!['reviews'].forEach((dynamic review) {
                reviews.add(Review.fromJson(review as Map<String, dynamic>));
              });
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      border: Border.all(
                        color: ColorConstants.grey2000,
                        width: 0.6,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      reviews[index].customer.profileImage ==
                                              null
                                          ? Container(
                                              height: 24,
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConstants.grey500,
                                              ),
                                              child:
                                                  Icon(Icons.person, size: 16),
                                            )
                                          : CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                StringConstants.baseStorageUrl +
                                                    reviews[index]
                                                        .customer
                                                        .profileImage
                                                        .toString(),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        reviews[index].customer.fullName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, top: 2.0),
                                    child: Text(
                                      DateFormat(StringConstants.dateFormat)
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  (reviews[index].at * 1000)
                                                      .toInt())),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  reviews[index].star.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                SvgPicture.asset(IconConstants.star),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            reviews[index].review,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: LoadingWidget());
            }
          },
        ),
      ),
    );
  }
}
