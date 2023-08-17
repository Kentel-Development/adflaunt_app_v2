import 'dart:ui';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/edit_listing/edit_listing_view.dart';
import 'package:adflaunt/feature/listing_details/listing_details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/l10n.dart';
import '../../models/listings/results.dart';

class ListingList extends StatefulWidget {
  const ListingList({
    super.key,
    required this.listing,
    this.isMyListing = false,
  });
  final Output listing;
  final bool isMyListing;
  @override
  State<ListingList> createState() => _ListingListState();
}

class _ListingListState extends State<ListingList>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Output listing;
  @override
  void initState() {
    listing = widget.listing;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => ListingDetailsView(
              listing: listing,
            ),
          ),
        ).then((value) => setState(() {
              if (value != null) {
                listing = value as Output;
              }
            }));
      },
      child: Container(
        height: widget.isMyListing ? 89 : 100,
        margin: EdgeInsets.only(left: 14, right: 21),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isMyListing
              ? Colors.white
              : ColorConstants.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topRight: widget.isMyListing
                        ? Radius.circular(4)
                        : Radius.circular(0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        StringConstants.baseStorageUrl + listing.images.first,
                    width: widget.isMyListing ? 92 : 85,
                    height: widget.isMyListing ? 69 : 100,
                    fit: BoxFit.cover,
                  ),
                ),
                widget.isMyListing
                    ? Container()
                    : Positioned(
                        top: 0,
                        left: 40,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(4)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(161, 161, 161, 0.5),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    IconConstants.star,
                                    height: 7.5,
                                    width: 3,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    listing.averageRating.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 7.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "(${listing.numberOfReviews})",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 7.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                  width: MediaQuery.of(context).size.width - 155,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(listing.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          )),
                      widget.isMyListing
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (context) => EditListingView(
                                      listing: listing,
                                    ),
                                  ),
                                ).then((value) => setState(() {
                                      if (value != null) {
                                        listing = value as Output;
                                      }
                                    }));
                              },
                              child: Container(
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(34),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).edit,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      IconConstants.edit,
                                      height: 13,
                                      width: 13,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SvgPicture.asset(
                              IconConstants.like,
                              height: 13,
                              width: 13,
                            ),
                    ],
                  ),
                ),
                Text(
                  "\$" + listing.price.toString() + "/day",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                  ),
                ),
                widget.isMyListing
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width - 155,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text(
                                  listing.typeOfAdd,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: ColorConstants.colorGray,
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            Container(
                              child: Text(
                                "${listing.height.round()}in X ${listing.width.round()}in ${listing.sqfeet.round()}sqft",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 23,
                              child: Text(
                                listing.tags.first,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            IconConstants.location,
                            height: 13,
                            width: 13,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(listing.location,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(
                            width: 16,
                          ),
                          Text("\$${listing.price}/day",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      )
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
