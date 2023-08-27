import 'dart:ui';

import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/services/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/padding_constants.dart';

import '../../../feature/listing_details/listing_details_view.dart';
import '../../models/listings/results.dart';
import '../../services/favorites.dart';

class ListingGrid extends StatefulWidget {
  const ListingGrid({
    super.key,
    required this.listing,
  });
  final Output listing;

  @override
  State<ListingGrid> createState() => _ListingGridState();
}

class _ListingGridState extends State<ListingGrid>
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
/*    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    void _onButtonPressed(String? img, String name) {
      _controller.forward();
      hostdetailsSheet(context, img, name, "8", _controller);
    }
*/
    return FutureBuilder(
        future: UserServices.getUser(listing.user),
        builder: (context, user) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute<dynamic>(
                builder: (context) {
                  return ListingDetailsView(
                    listing: listing,
                  );
                },
              )).then((value) {
                if (value != null) {
                  setState(() {
                    listing = value as Output;
                  });
                }
              });
            },
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                StringConstants.baseStorageUrl +
                                    listing.images.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(161, 161, 161, 0.5),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    IconConstants.star,
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    listing.averageRating.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "(${listing.numberOfReviews})",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Positioned(
                        bottom: 10,
                        left: 10,
                        child: SizedBox(
                            height: deviceH / 16,
                            width: deviceH / 16.2,
                            child: GestureDetector(
                              onTap: () {
                                if (user.hasData) {
                                  _onButtonPressed(
                                      user.data!.profileImage.toString(),
                                      user.data!.fullName);
                                }
                              },
                              child: Stack(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: CustomPaint(
                                      size: Size(
                                          deviceW, (deviceW * 1.1).toDouble()),
                                      painter: HostCardPainter(),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 5,
                                    right: 15,
                                    child: user.hasData &&
                                            user.data!.profileImage != null
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      0, 0, 0, 0.25)),
                                              image: DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                      StringConstants
                                                              .baseStorageUrl +
                                                          user.data!
                                                              .profileImage!.toString()),
                                                  fit: BoxFit.contain),
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      0, 0, 0, 0.25)),
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )),
                      ),*/
                    ],
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              PaddingConstants.smallPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(listing.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box<List<String>>("favorites")
                                          .listenable(),
                                  builder: (context, box, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        FavoriteService.addFavorite(
                                            box, listing.id.toString());
                                      },
                                      child: box.get("favorites",
                                              defaultValue: [])!.contains(listing.id!)
                                          ? SvgPicture.asset(
                                              IconConstants.like,
                                              // ignore: deprecated_member_use
                                              color: Colors.black,
                                            )
                                          : SvgPicture.asset(
                                              IconConstants.like,
                                            ),
                                    );
                                  })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingConstants.smallPadding,
                              vertical: PaddingConstants.smallPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      IconConstants.location,
                                      height: 13,
                                      width: 13,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(listing.location,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Text("\$${listing.price}/day",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          );
        });
  }
}
