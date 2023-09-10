import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/icon_constants.dart';
import '../../core/constants/string_constants.dart';

class ReviewWidget extends StatelessWidget {
  final dynamic profileImage;
  final String fullName;
  final String review;
  final double star;
  final double at;
  const ReviewWidget(
      {required this.profileImage,
      required this.fullName,
      required this.review,
      required this.star,
      required this.at,
      super.key});

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        profileImage == null
                            ? Container(
                                height: 24,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.grey500,
                                ),
                                child: Icon(Icons.person, size: 16),
                              )
                            : CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                  StringConstants.baseStorageUrl +
                                      profileImage.toString(),
                                ),
                              ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat(StringConstants.dateFormat).format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (at * 1000).toInt())),
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
                    star.toString(),
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
              review,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
