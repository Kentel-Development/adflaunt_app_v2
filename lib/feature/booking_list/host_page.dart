import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/extensions/string_extensions.dart';
import 'package:adflaunt/feature/chat/chat_view.dart';
import 'package:adflaunt/feature/listing_details/fullscreen_imageview.dart';
import 'package:adflaunt/feature/tab_view.dart';
import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/services/download.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/constants/icon_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../generated/l10n.dart';
import '../../product/services/ads_preview.dart';
import '../../product/services/chat.dart';
import '../../product/services/user.dart';

// ignore: must_be_immutable
class HostPage extends StatefulWidget {
  HostPage(this.asHost, this.bookingId, {this.fromChat = false, super.key});
  As? asHost;
  String bookingId;
  bool fromChat;
  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  As? asHost;
  @override
  void initState() {
    if (widget.asHost != null) {
      asHost = widget.asHost!;
    } else {
      BookingService.getBookingDetails(widget.bookingId).then((value) {
        setState(() {
          asHost = value;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    bool loading2 = false;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: widget.fromChat == true
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(42),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Header(
                    hasBackBtn: true,
                    title: asHost == null ? "" : asHost!.listingData!.title!),
              ),
            ),
      body: asHost == null
          ? Center(
              child: LoadingWidget(),
            )
          : asHost!.toJson()["status"] == "Not found"
              ? Center(
                  child: Text(
                    S.of(context).thisBookingHasBeenDeleted,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      color: Color.fromRGBO(122, 122, 122, 1),
                    ),
                  ),
                )
              : FutureBuilder(
                  future: UserServices.getUser(asHost!.data!.customer!),
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
                                asHost!
                                    .status!.camelCaseToNormal.capitalizeFirst,
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
                                snapshot.hasData &&
                                        snapshot.data!.profileImage != null
                                    ? CircleAvatar(
                                        radius: 24,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                StringConstants.baseStorageUrl +
                                                    snapshot.data!.profileImage
                                                        .toString()),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Text(S.of(context).client,
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
                                  asHost!.listingData!.title!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                  ),
                                  child: Text(
                                    asHost!.listingData!.typeOfAdd!,
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
                                    asHost!.data!.daysWantToBook!.length
                                        .toString() +
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
                                  asHost!.data!.price.toString().toPriceFormat,
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
                                          color: snapshot.data!.idVerified
                                              ? Color.fromRGBO(9, 140, 38, 1)
                                              : Color.fromRGBO(221, 27, 73, 1),
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
                                            color: snapshot.data!.idVerified
                                                ? Color.fromRGBO(9, 140, 38, 1)
                                                : Color.fromRGBO(
                                                    221, 27, 73, 1),
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
                            asHost!.status == "active"
                                ? asHost!.data!.proofs == null
                                    ? buildUploadProof()
                                    : Column(
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
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          buildImageView(),
                                        ],
                                      )
                                : asHost!.status == "waitingForApproval"
                                    ? buildApproveDeclineButtons(
                                        loading, loading2)
                                    : asHost!.status == "completed"
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
                                                ),
                                              ),
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
                              height: asHost!.listingData!.tags![1] != "Digital"
                                  ? 0
                                  : 12,
                            ),
                            asHost!.listingData!.tags![1] == "Digital"
                                ? buildDigitalAd(context)
                                : Container(),
                            SizedBox(
                              height: widget.fromChat ? 0 : 12,
                            ),
                            widget.fromChat
                                ? Container()
                                : buildMessageButton(context, asHost!),
                            SizedBox(
                              height: 16,
                            ),
                            snapshot.hasData
                                ? snapshot.data!.phoneNumber == null
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          launchUrlString("tel://" +
                                              snapshot.data!.phoneNumber
                                                  .toString());
                                        },
                                        child: Text(
                                          S.of(context).phone +
                                              ": +" +
                                              snapshot.data!.phoneNumber
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.black),
                                        ),
                                      )
                                : Container(),
                            SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).filePreview,
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
                            FutureBuilder(
                              future: LivePreviewService.getLivePreview(
                                  asHost!.data!.bookingId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final content = snapshot.data as List<String>;
                                  return SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: content.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute<dynamic>(
                                              builder: (context) {
                                                return PhotoGalleryView(
                                                    images: content,
                                                    currentIndex: index);
                                              },
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 8),
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        StringConstants
                                                                .baseUrl +
                                                            "/" +
                                                            content[index]
                                                                .toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else {
                                  return Center(child: LoadingWidget());
                                }
                              },
                            ),
                            SizedBox(height: 8),
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
                                    asHost!.listingData!.height!
                                            .round()
                                            .toString() +
                                        " x " +
                                        asHost!.listingData!.width!
                                            .round()
                                            .toString() +
                                        " = " +
                                        asHost!.listingData!.sqfeet!
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            DateFormat(
                                                    StringConstants.dateFormat)
                                                .format(DateTime.parse(asHost!
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            DateFormat(
                                                    StringConstants.dateFormat)
                                                .format(DateTime.parse(asHost!
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

  GestureDetector buildDigitalAd(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (asHost!.data!.printingFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).noFilesUploaded)));
        } else {
          String url =
              "${StringConstants.baseUrl}/smartdisplay/${widget.bookingId}";
          Share.share(url, subject: S.of(context).digitalAdDisplayPanel);
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
            S.of(context).digitalAdDisplayPanel,
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
        itemCount: asHost!.data!.proofs!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute<dynamic>(
                builder: (context) {
                  return PhotoGalleryView(
                      images: asHost!.data!.proofs!, currentIndex: index);
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
                          asHost!.data!.proofs![index].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  StatefulBuilder buildUploadProof() {
    bool loading = false;
    return StatefulBuilder(builder: (context, state) {
      return GestureDetector(
        onTap: () async {
          if (!loading) {
            final imagePicker = ImagePicker();
            final pickedFile =
                await imagePicker.pickMultiImage(imageQuality: 1);
            if (pickedFile.length > 0) {
              state(() {
                loading = true;
              });
              try {
                print((await BookingService.uploadProof(
                  asHost!.listingData!.id.toString(),
                  asHost!.data!.bookingId.toString(),
                  pickedFile,
                ))
                    .body);

                final response =
                    await BookingService.getBookingDetails(widget.bookingId);
                setState(() {
                  asHost = response;
                });
                state(() {
                  loading = false;
                });
              } catch (e) {
                state(() {
                  loading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
            }
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
                ? LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [Colors.white])
                : Text(
                    S.of(context).uploadProofToMarkAsCompleted,
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
          if (!loading) {
            state(() {
              loading = true;
            });
            if (asHost!.data!.printingFile == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).noFilesUploaded)));
              state(() {
                loading = false;
              });
            } else {
              final file = await DownloadService.downloadFile(
                  asHost!.data!.printingFile.toString());
              state(() {
                loading = false;
              });
              Share.shareXFiles([XFile(file.path)]);
            }
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

  StatefulBuilder buildApproveDeclineButtons(bool loading, bool loading2) {
    return StatefulBuilder(builder: (context, state) {
      return Column(
        children: [
          GestureDetector(
            onTap: () async {
              if (!loading) {
                state(() {
                  loading = true;
                });
                try {
                  await BookingService.approveBooking(
                      asHost!.data!.bookingId.toString());
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
                final response =
                    await BookingService.getBookingDetails(widget.bookingId);
                state(() {
                  loading = false;
                });
                setState(() {
                  asHost = response;
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
                        S.of(context).approveBooking,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () async {
              if (!loading2) {
                state(() {
                  loading2 = true;
                });
                try {
                  await BookingService.rejectBooking(
                      asHost!.data!.bookingId.toString());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (context) => TabView(),
                      ),
                      (route) => false);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
                state(() {
                  loading2 = false;
                });
              }
            },
            child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromRGBO(221, 27, 73, 1),
              ),
              child: loading2
                  ? Center(
                      child: SizedBox(
                          height: 20,
                          width: 40,
                          child: const LoadingIndicator(
                              colors: [Colors.white],
                              indicatorType: Indicator.ballPulseSync)),
                    )
                  : Center(
                      child: Text(
                        S.of(context).decline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      ),
                    ),
            ),
          ),
        ],
      );
    });
  }
}

GestureDetector buildMessageButton(BuildContext context, As asHost) {
  return GestureDetector(
    onTap: () async {
      String id = await ChatServices.createChat(
          asHost.data!.customer!, asHost.listingData!.id!);
      try {
        Navigator.push(context, MaterialPageRoute<dynamic>(
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
