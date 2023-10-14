import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/booking/booking_view.dart';
import 'package:adflaunt/feature/chat/chat_view.dart';
import 'package:adflaunt/feature/edit_listing/edit_listing_view.dart';
import 'package:adflaunt/feature/listing_details/fullscreen_imageview.dart';
import 'package:adflaunt/feature/review/review_view.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/services/chat.dart';
import 'package:adflaunt/product/services/reviews.dart';
import 'package:adflaunt/product/services/user.dart';
import 'package:adflaunt/product/widgets/headers/common_heading.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/listing/ad_specs.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:adflaunt/product/widgets/review_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../generated/l10n.dart';
import '../../product/widgets/listing/tags.dart';
import '../user_profile/user_profile_view.dart';

class ListingDetailsView extends StatefulWidget {
  final Output listing;
  const ListingDetailsView({required this.listing, super.key});

  @override
  State<ListingDetailsView> createState() => _ListingDetailsViewState();
}

class _ListingDetailsViewState extends State<ListingDetailsView>
    with SingleTickerProviderStateMixin {
  late int selectedPage;
  late final PageController pageController;
  late Output listing;
  late List<String> adSpecs;
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    listing = widget.listing;
    adSpecs = [
      listing.typeOfAdd,
      listing.tags[0],
      listing.tags[1],
      "${listing.height.round()}in X ${listing.width.round()}in = ${listing.sqfeet.round()} sqft",
    ];
    selectedPage = 0;
    pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listing.cancel == true &&
        !adSpecs.contains(S.of(context).freeCancellation)) {
      adSpecs.add(S.of(context).freeCancellation);
    }
    if (listing.cancel == false &&
        adSpecs.contains(S.of(context).freeCancellation)) {
      adSpecs.remove(S.of(context).freeCancellation);
    }

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (listing.user ==
                        Hive.box<ProfileAdapter>("user").get("userData")!.id) {
                      Navigator.push(context, MaterialPageRoute<dynamic>(
                        builder: (context) {
                          return EditListingView(
                            listing: listing,
                          );
                        },
                      )).then((value) => setState(() {
                            if (value != null) {
                              listing = value as Output;
                            }
                          }));
                    } else {
                      Navigator.push(context, MaterialPageRoute<dynamic>(
                        builder: (context) {
                          return BookingView(
                            listing: listing,
                          );
                        },
                      ));
                    }
                  },
                  child: Container(
                    width: 150,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        listing.user ==
                                Hive.box<ProfileAdapter>("user")
                                    .get("userData")!
                                    .id
                            ? S.of(context).edit
                            : S.of(context).bookNow,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "\$${listing.price.toStringAsFixed(2)}" +
                        " / " +
                        S.of(context).perDay,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(
            hasBackBtn: true,
            title: S.of(context).listingDetails,
            onLeftIconTap: () {
              Navigator.pop(context, listing);
            },
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return PhotoGalleryView(
                        images: listing.images,
                        currentIndex: selectedPage,
                      );
                    },
                  ));
                },
                child: SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (page) {
                      setState(() {
                        selectedPage = page;
                      });
                    },
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: listing.images.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: StringConstants.baseStorageUrl +
                            listing.images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                  bottom: 18,
                  right: 25,
                  child: (listing.user ==
                          Hive.box<ProfileAdapter>("user").get("userData")!.id!)
                      ? Container()
                      : GestureDetector(
                          onTap: () async {
                            String id = await ChatServices.createChat(
                                listing.user, listing.id!);
                            try {
                              Navigator.push(context,
                                  MaterialPageRoute<dynamic>(
                                builder: (context) {
                                  return ChatView(
                                    chatId: id,
                                  );
                                },
                              ));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
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
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              height: 8,
              child: PageViewDotIndicator(
                currentItem: selectedPage,
                count: listing.images.length,
                unselectedColor: Color.fromRGBO(217, 217, 217, 1),
                selectedColor: Colors.black,
                duration: Duration(milliseconds: 200),
                boxShape: BoxShape.rectangle,
                size: Size.fromWidth(14),
                unselectedSize: Size.fromWidth(8),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    listing.title,
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
                      listing.location,
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
                          listing.averageRating.toString() +
                              "(" +
                              listing.numberOfReviews.toString() +
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
                    listing.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                listing.tags.length > 2 ? Tags(widget: listing) : Container(),
                SizedBox(
                  height: 6,
                ),
                Divider(),
                SizedBox(
                  height: 6,
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
                  height: 6,
                ),
                Divider(),
                FutureBuilder(
                  future: UserServices.getUserProfile(widget.listing.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: LoadingWidget(),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute<dynamic>(
                          builder: (context) {
                            return UserProfileView(
                              userProfileModel: snapshot.data,
                              id: widget.listing.user,
                            );
                          },
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              snapshot.data!.user!.profileImage == null
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
                                      radius: 24,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        StringConstants.baseStorageUrl +
                                            snapshot.data!.user!.profileImage
                                                .toString(),
                                      ),
                                    ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.user!.fullName!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.yearsOfHosting
                                            .toString()
                                            .toLowerCase() +
                                        " " +
                                        "hosting",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                IconConstants.star,
                                height: 18,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                snapshot.data!.averageRating.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                Divider(),
                SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GoogleMap(
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        compassEnabled: false,
                        markers: {}..add(
                            Marker(
                              markerId: MarkerId("1"),
                              position: LatLng(listing.lat.toDouble(),
                                  listing.long.toDouble()),
                            ),
                          ),
                        initialCameraPosition: CameraPosition(
                            target: LatLng(listing.lat.toDouble(),
                                listing.long.toDouble()),
                            zoom: 12)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          listing.location,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("State: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        Text(
                          listing.state,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("City: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        Text(
                          listing.city,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(S.of(context).crossStreet + ": ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        Text(
                          listing.country,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Zip Code: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        Text(
                          listing.zipCode,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    if (listing.reviews!.length > 0) {
                      Navigator.push(context, MaterialPageRoute<dynamic>(
                        builder: (context) {
                          return ReviewView(
                            listingId: listing.id!,
                          );
                        },
                      ));
                    }
                  },
                  child: CommonHeading(
                    headingText: S.of(context).reviews,
                    hasMargin: false,
                    hasSpacing: false,
                    onPress: false,
                    hasBtn: listing.reviews != null
                        ? listing.reviews!.length > 0
                            ? true
                            : false
                        : false,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      listing.averageRating.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorConstants.grey500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                buildCategorizeReviews(),
                buildReviews(),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> buildCategorizeReviews() {
    return FutureBuilder(
      future: ReviewService.categorizeReviews(widget.listing.id!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as Map<String, dynamic>;
          Map<String, dynamic> ratings = {
            "5": 0,
            "4": 0,
            "3": 0,
            "2": 0,
            "1": 0,
          };
          data.forEach((key, value) {
            key.substring(0, 1);
            ratings[key.substring(0, 1)] = ratings[key.substring(0, 1)] + value;
          });
          print(ratings);
          return Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    Expanded(
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(8),
                        lineHeight: 8.0,
                        percent: double.parse(
                            (ratings["1"] / listing.numberOfReviews)
                                .toString()),
                        backgroundColor: ColorConstants.grey2000,
                        progressColor: Color.fromRGBO(254, 195, 13, 1),
                      ),
                    ),
                    Center(
                      child: Text(
                        ratings["1"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromRGBO(161, 161, 170, 1),
                            fontFamily: "Poppins"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(8),
                        lineHeight: 8.0,
                        percent: double.parse(
                            (ratings["2"] / listing.numberOfReviews)
                                .toString()),
                        backgroundColor: ColorConstants.grey2000,
                        progressColor: Color.fromRGBO(254, 195, 13, 1),
                      ),
                    ),
                    Center(
                      child: Text(
                        ratings["2"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromRGBO(161, 161, 170, 1),
                            fontFamily: "Poppins"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(8),
                        lineHeight: 8.0,
                        percent: double.parse(
                            (ratings["3"] / listing.numberOfReviews)
                                .toString()),
                        backgroundColor: ColorConstants.grey2000,
                        progressColor: Color.fromRGBO(254, 195, 13, 1),
                      ),
                    ),
                    Center(
                      child: Text(
                        ratings["3"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromRGBO(161, 161, 170, 1),
                            fontFamily: "Poppins"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(8),
                        lineHeight: 8.0,
                        percent: double.parse(
                            (ratings["4"] / listing.numberOfReviews)
                                .toString()),
                        backgroundColor: ColorConstants.grey2000,
                        progressColor: Color.fromRGBO(254, 195, 13, 1),
                      ),
                    ),
                    Center(
                      child: Text(
                        ratings["4"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromRGBO(161, 161, 170, 1),
                            fontFamily: "Poppins"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      IconConstants.star,
                      height: 18,
                    ),
                    Expanded(
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(8),
                        lineHeight: 8.0,
                        percent: double.parse(
                            (ratings["5"] / listing.numberOfReviews)
                                .toString()),
                        backgroundColor: ColorConstants.grey2000,
                        progressColor: Color.fromRGBO(254, 195, 13, 1),
                      ),
                    ),
                    Center(
                      child: Text(
                        ratings["5"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromRGBO(161, 161, 170, 1),
                            fontFamily: "Poppins"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  ListView buildReviews() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8,
        );
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: listing.reviews == null
          ? 0
          : listing.reviews!.length > 3
              ? 3
              : listing.reviews!.length,
      itemBuilder: (context, index) {
        return ReviewWidget(
            profileImage: listing.reviews![index].customer.profileImage,
            fullName: listing.reviews![index].customer.fullName,
            review: listing.reviews![index].review,
            star: listing.reviews![index].star,
            at: listing.reviews![index].at);
      },
    );
  }
}
