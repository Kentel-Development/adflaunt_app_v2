import 'package:adflaunt/core/extensions/string_extensions.dart';
import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/string_constants.dart';

// ignore: must_be_immutable
class BookingList extends StatefulWidget {
  BookingList({required this.listingData, this.status, super.key});
  ListingData listingData;
  String? status;
  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 89,
        margin: EdgeInsets.only(left: 14, right: 21),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
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
                    topRight: Radius.circular(4),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: StringConstants.baseStorageUrl +
                        widget.listingData.images!.first,
                    width: 92,
                    height: 69,
                    fit: BoxFit.cover,
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
                      Text(widget.listingData.title!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                        height: 30,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Text(
                            widget.status
                                .toString()
                                .camelCaseToNormal
                                .capitalizeFirst,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            )),
                      )
                    ],
                  ),
                ),
                Text(
                  "\$" + widget.listingData.price.toString() + "/day",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 155,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text(
                            widget.listingData.typeOfAdd!,
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
                          "${widget.listingData.height!.round()}in X ${widget.listingData.width!.round()}in = ${widget.listingData.sqfeet!.round()}sqft",
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
                        child: Center(
                          child: Text(
                            widget.listingData.tags!.first,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
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
              ],
            ),
            Spacer(),
          ],
        ));
  }
}
