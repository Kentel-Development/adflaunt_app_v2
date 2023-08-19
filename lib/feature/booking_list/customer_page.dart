import 'dart:convert';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/listing_details/fullscreen_imageview.dart';
import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/services/chat.dart';
import 'package:adflaunt/product/services/download.dart';
import 'package:adflaunt/product/services/user.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/review_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:adflaunt/core/extensions/string_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';

import '../../generated/l10n.dart';
import '../../product/models/chat/inbox.dart' as chat;
import '../../product/models/profile/profile_model.dart';
import '../chat/chat_view.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({this.asCustomer, this.fromChat = false, super.key});
  final As? asCustomer;
  final bool fromChat;
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late As asCustomer;
  @override
  void initState() {
    if (widget.asCustomer != null) {
      asCustomer = widget.asCustomer!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: widget.fromChat
          ? PreferredSize(
              child: Container(),
              preferredSize: const Size.fromHeight(42),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(42),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Header(
                    hasBackBtn: true, title: asCustomer.listingData!.title!),
              ),
            ),
      body: FutureBuilder(
          future: UserServices.getUser(asCustomer.listingData!.user!),
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(top: 36, left: 24, right: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        asCustomer.status!.camelCaseToNormal.capitalizeFirst,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(122, 122, 122, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        snapshot.hasData && snapshot.data!.profileImage != null
                            ? CircleAvatar(
                                radius: 24,
                                backgroundImage: CachedNetworkImageProvider(
                                    StringConstants.baseStorageUrl +
                                        snapshot.data!.profileImage.toString()),
                              )
                            : CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.hasData
                                  ? snapshot.data!.fullName.toString()
                                  : '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(S.of(context).host,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                ))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          asCustomer.listingData!.title!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Text(
                            asCustomer.listingData!.typeOfAdd!,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).inquiryFor +
                            asCustomer.data!.daysWantToBook!.length.toString() +
                            S.of(context).days,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\$" + asCustomer.data!.price.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        )),
                    SizedBox(
                      height: 6,
                    ),
                    snapshot.hasData
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  snapshot.data!.idVerified
                                      ? IconConstants.check_ring
                                      : IconConstants.cross_ring,
                                  // ignore: deprecated_member_use
                                  color: Color.fromRGBO(161, 161, 161, 1),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  snapshot.data!.idVerified
                                      ? S.of(context).idVerified
                                      : S.of(context).idNotVerified,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(161, 161, 161, 1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 12,
                    ),
                    asCustomer.status == "active"
                        ? asCustomer.data!.proofs != null
                            ? Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.of(context).proofs,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                        ),
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  buildImageView(),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  approveProofs(context),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    S
                                        .of(context)
                                        .theBookingWillBeCompletedOnceYouApproveTheProofs,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                        : asCustomer.status == "completed"
                            ? Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.of(context).proofs,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                        ),
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  buildImageView(),
                                ],
                              )
                            : Container(),
                    SizedBox(
                      height: 12,
                    ),
                    buildDownloadAdFiles(context),
                    SizedBox(
                      height: widget.fromChat ? 0 : 12,
                    ),
                    widget.fromChat ? Container() : buildMessageButton(context),
                    SizedBox(
                      height: 16,
                    ),
                    snapshot.hasData
                        ? snapshot.data!.phoneNumber == null
                            ? Container()
                            : Text(S.of(context).phone +
                                ": +" +
                                snapshot.data!.phoneNumber.toString())
                        : Container(),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).bookingInformation,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).spaceSize,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            asCustomer.listingData!.height!.round().toString() +
                                " x " +
                                asCustomer.listingData!.width!
                                    .round()
                                    .toString() +
                                " = " +
                                asCustomer.listingData!.sqfeet!
                                    .round()
                                    .toString() +
                                " sqft",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    S.of(context).bookingStarts,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    DateFormat(StringConstants.dateFormat)
                                        .format(DateTime.parse(asCustomer
                                            .data!.daysWantToBook!.first
                                            .toString())),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    S.of(context).bookingEnds,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    DateFormat(StringConstants.dateFormat)
                                        .format(DateTime.parse(asCustomer
                                            .data!.daysWantToBook!.last
                                            .toString())),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  StatefulBuilder approveProofs(BuildContext context) {
    bool loading = false;
    return StatefulBuilder(builder: (context, state) {
      return GestureDetector(
        onTap: () async {
          if (!loading) {
            showModalBottomSheet<dynamic>(
              context: context,
              builder: (context) => const ReviewModalSheet(),
            ).then((value) async {
              if (value != null) {
                if (value["rating"] == 0.0 &&
                    value["comment"].toString().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          S.of(context).theRatingAndCommentCannotBeEmpty)));
                  return;
                }
                if (value["rating"] == 0.0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).theRatingCannotBe0)));
                  return;
                }
                if (value["comment"].toString().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).theCommentCannotBeEmpty)));
                  return;
                }
                try {
                  state(() {
                    loading = true;
                  });
                  final response = await BookingService.addReview(
                      asCustomer.listingData!.id!,
                      asCustomer.data!.bookingId!,
                      value["rating"].toString(),
                      value["comment"].toString());
                  if (jsonDecode(response.body)["SCC"] == true) {
                    final res = await BookingService.getBookingDetails(
                        asCustomer.data!.bookingId!);
                    setState(() {
                      asCustomer = res;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(jsonDecode(response.body)["err"].toString())));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
                state(() {
                  loading = false;
                });
              }
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: Center(
            child: loading
                ? SizedBox(
                    height: 20,
                    width: 40,
                    child: const LoadingIndicator(
                        colors: [Colors.white],
                        indicatorType: Indicator.ballPulseSync))
                : Text(
                    S.of(context).completeBooking,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        color: Colors.white),
                  ),
          ),
        ),
      );
    });
  }

  StatefulBuilder buildDownloadAdFiles(BuildContext context) {
    bool loading = false;
    return StatefulBuilder(builder: (context, state) {
      return GestureDetector(
        onTap: () async {
          state(() {
            loading = true;
          });
          if (asCustomer.data!.printingFile == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).noFilesUploaded)));
            state(() {
              loading = false;
            });
          } else {
            final file = await DownloadService.downloadFile(
                asCustomer.data!.printingFile.toString());
            state(() {
              loading = false;
            });
            Share.shareXFiles([XFile(file.path)]);
          }
        },
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: Center(
            child: loading
                ? SizedBox(
                    height: 20,
                    width: 40,
                    child: const LoadingIndicator(
                        colors: [Colors.white],
                        indicatorType: Indicator.ballPulseSync))
                : Text(
                    S.of(context).downloadAdFiles,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        color: Colors.white),
                  ),
          ),
        ),
      );
    });
  }

  GestureDetector buildMessageButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ProfileModel user =
            await UserServices.getUser(widget.asCustomer!.listingData!.user!);
        String id = await ChatServices.createChat(
            widget.asCustomer!.listingData!.user!,
            widget.asCustomer!.listingData!.id!);
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
                    ipdata: chat.Ipdata.fromJson(user.ipdata.toJson()),
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
      },
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            S.of(context).message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  SizedBox buildImageView() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: asCustomer.data!.proofs!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute<dynamic>(
                builder: (context) {
                  return PhotoGalleryView(
                      images: asCustomer.data!.proofs!, currentIndex: index);
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      StringConstants.baseStorageUrl +
                          asCustomer.data!.proofs![index].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
