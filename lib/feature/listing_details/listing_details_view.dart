import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/booking/booking_view.dart';
import 'package:adflaunt/feature/chat/chat_view.dart';
import 'package:adflaunt/feature/edit_listing/edit_listing_view.dart';
import 'package:adflaunt/feature/listing_details/fullscreen_imageview.dart';
import 'package:adflaunt/product/models/chat/inbox.dart' as chat;
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/services/chat.dart';
import 'package:adflaunt/product/services/user.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/listing/ad_specs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../../generated/l10n.dart';
import '../../product/widgets/listing/tags.dart';

class ListingDetailsView extends StatefulWidget {
  final Output listing;
  const ListingDetailsView({required this.listing, super.key});

  @override
  State<ListingDetailsView> createState() => _ListingDetailsViewState();
}

class _ListingDetailsViewState extends State<ListingDetailsView> {
  late int selectedPage;
  late final PageController pageController;
  late Output listing;
  late List<String> adSpecs;
  @override
  void initState() {
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
    if (listing.cancel!) {
      adSpecs.add(S.of(context).freeCancellation);
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
                    "\$${listing.price}" + " / " + S.of(context).perDay,
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
                  child: GestureDetector(
                    onTap: () async {
                      if (listing.user !=
                          Hive.box<ProfileAdapter>("user")
                              .get("userData")!
                              .id!) {
                        ProfileModel user =
                            await UserServices.getUser(listing.user);
                        String id = await ChatServices.createChat(
                            listing.user, listing.id!);
                        try {
                          Navigator.push(context, MaterialPageRoute<dynamic>(
                            builder: (context) {
                              return ChatView(
                                chatId: id,
                                user: chat.Them(
                                    id: user.id,
                                    fullName: user.fullName,
                                    backPhotoId: "",
                                    dateOfBirth: user.dateOfBirth == null
                                        ? DateTime.now().toString()
                                        : user.dateOfBirth!,
                                    deliveryAddress: "",
                                    email: user.email,
                                    idVerified: user.idVerified,
                                    inbox: [""],
                                    ipdata: chat.Ipdata.fromJson(
                                        user.ipdata.toJson()),
                                    ipraw: user.ipraw,
                                    lastTimeLoggedIn: 0,
                                    profileImage: user.profileImage,
                                    phoneNumber: user.phoneNumber == null
                                        ? ""
                                        : user.phoneNumber.toString(),
                                    photoOfId: "",
                                    thirdParty: user.thirdParty),
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
                        Text("Country: ",
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).reviews,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
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
                buildReviews()
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView buildReviews() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: listing.reviews == null
          ? 0
          : listing.reviews!.length > 3
              ? 3
              : listing.reviews!.length,
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
                            listing.reviews![index].customer.profileImage ==
                                    null
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
                                          listing.reviews![index].customer
                                              .profileImage
                                              .toString(),
                                    ),
                                  ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              listing.reviews![index].customer.fullName,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, top: 2.0),
                          child: Text(
                            DateFormat(StringConstants.dateFormat).format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    (listing.reviews![index].at * 1000)
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
                        listing.reviews![index].star.toString(),
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
                  listing.reviews![index].review,
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
  }
}
