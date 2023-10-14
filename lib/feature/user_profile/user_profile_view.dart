import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/review/review_user_view.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/models/user_profile_model.dart' as model;
import 'package:adflaunt/product/services/user.dart';
import 'package:adflaunt/product/widgets/headers/common_heading.dart';
import 'package:adflaunt/product/widgets/listing/listing_grid.dart';
import 'package:adflaunt/product/widgets/review_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileView extends StatefulWidget {
  UserProfileView({this.userProfileModel, required this.id, super.key});
  final String id;
  final model.UserProfileModel? userProfileModel;
  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late model.UserProfileModel userProfileModel;
  String? strPart;
  int? intPart;
  @override
  void initState() {
    if (widget.userProfileModel != null) {
      userProfileModel = widget.userProfileModel!;
      if (userProfileModel.yearsOfHosting != "No Listings") {
        final List<String> parts = userProfileModel.yearsOfHosting!.split(' ');
        strPart = parts[1];
        intPart = int.parse(parts[0]);
      }
    } else {
      UserServices.getUserProfile(widget.id).then((value) {
        if (value.yearsOfHosting != "No Listings") {
          final List<String> parts = value.yearsOfHosting!.split(' ');
          strPart = parts[1];
          intPart = int.parse(parts[0]);
        }

        setState(() {
          userProfileModel = value;
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(94),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0,
                    left: 8,
                    child: IconButton(
                      icon: SvgPicture.asset(IconConstants.arrowLeft),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userProfileModel.user!.profileImage == null
                        ? CircleAvatar(
                            radius: 24,
                            backgroundColor: ColorConstants.grey500,
                            child: Icon(
                              Icons.person,
                              size: 24,
                              color: Colors.white,
                            ),
                          )
                        : CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.transparent,
                            backgroundImage: CachedNetworkImageProvider(
                                StringConstants.baseStorageUrl +
                                    userProfileModel.user!.profileImage!),
                          ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      userProfileModel.user!.fullName!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ],
            ),
          )),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(211, 211, 211, 0.25),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(211, 211, 211, 0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(211, 211, 211, 0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(211, 211, 211, 0.25),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userProfileModel.numberOfReviews!
                                  .round()
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              'Reviews',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (intPart ?? "No Listings").toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              strPart ?? "" + ' Hosting',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userProfileModel.averageRating.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              'Rating',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                userProfileModel.numberOfReviews! < 1
                    ? Container()
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (context) {
                                    return ReviewUserView(
                                        listingId: userProfileModel.user!.id!);
                                  },
                                ),
                              );
                            },
                            child: CommonHeading(
                              hasMargin: false,
                              hasSpacing: false,
                              hasBtn: true,
                              onPress: false,
                              headingText:
                                  "${userProfileModel.user!.fullName}'s Reviews",
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ReviewWidget(
                                  profileImage: userProfileModel.user!
                                      .reviews![index].customer!.profileImage,
                                  fullName: userProfileModel.user!
                                      .reviews![index].customer!.fullName!,
                                  review: userProfileModel
                                      .user!.reviews![index].review!,
                                  star: userProfileModel
                                      .user!.reviews![index].star!,
                                  at: userProfileModel
                                      .user!.reviews![index].at!);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 8,
                              );
                            },
                            itemCount: userProfileModel.user!.reviews!.length,
                          )
                        ],
                      ),
                userProfileModel.listings != null &&
                        userProfileModel.listings!.isNotEmpty
                    ? Column(
                        children: [
                          CommonHeading(
                              hasMargin: false,
                              hasSpacing: false,
                              hasBtn: false,
                              onPress: false,
                              headingText:
                                  "${userProfileModel.user!.fullName}'s Listings"),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              itemCount: userProfileModel.listings!.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 16,
                                );
                              },
                              itemBuilder: (context, index) {
                                final json =
                                    userProfileModel.listings![index].toJson();
                                json["requirements"] = userProfileModel
                                    .listings![index].requirements!
                                    .toJson();
                                json["reviews"] = userProfileModel
                                    .listings![index].reviews!
                                    .map((e) {
                                  final json = e.toJson();
                                  final customer = e.customer!.toJson();
                                  customer["IPDATA"] =
                                      e.customer!.ipdata!.toJson();
                                  customer.remove("orders");
                                  json["customer"] = customer;
                                  return json;
                                }).toList();

                                return SizedBox(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            32,
                                    child: ListingGrid(
                                        listing: Output.fromJson(json),
                                        color: true));
                              },
                            ),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
