import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/feature/listing_details/listing_details_view.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/string_constants.dart';
import '../../product/services/favorites.dart';

class AllListingsView extends StatelessWidget {
  const AllListingsView(
      {required this.title,
      required this.type,
      required this.category,
      required this.from,
      required this.to,
      required this.priceStart,
      required this.priceEnd,
      required this.lat,
      required this.lng,
      required this.installationDate,
      required this.removalDate,
      required this.states,
      required this.city,
      required this.country,
      required this.zip,
      super.key});
  final String title;
  final int? type;
  final String? category;
  final String? from;
  final String? to;
  final String? priceStart;
  final String? priceEnd;
  final String? lat;
  final String? lng;
  final DateTime? installationDate;
  final DateTime? removalDate;
  final String? states;
  final String? city;
  final String? country;
  final String? zip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Header(hasBackBtn: true, title: title),
          ),
        ),
        body: FutureBuilder(
          future: ListingsAPI.listingsFilterer(
            type,
            category,
            from,
            to,
            priceStart,
            priceEnd,
            lat,
            lng,
            title == S.of(context).digitalAds ? "Digital" : "",
            title == S.of(context).adSpacesNearYou ? "20" : null,
            city,
            states,
            country,
            zip,
            installationDate,
            removalDate,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute<dynamic>(
                            builder: (context) {
                              return ListingDetailsView(
                                listing: snapshot.data![index],
                              );
                            },
                          ));
                        },
                        child: Container(
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
                                        imageUrl: StringConstants
                                                .baseStorageUrl +
                                            snapshot.data![index].images.first,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width -
                                          155,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                                snapshot.data![index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                )),
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable:
                                                  Hive.box<List<String>>(
                                                          "favorites")
                                                      .listenable(),
                                              builder: (context, box, child) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    FavoriteService.addFavorite(
                                                        box,
                                                        snapshot.data![index].id
                                                            .toString());
                                                  },
                                                  child:
                                                      box.get("favorites", defaultValue: [])!.contains(
                                                              snapshot
                                                                  .data![index]
                                                                  .id!)
                                                          ? SvgPicture.asset(
                                                              IconConstants
                                                                  .like,
                                                              // ignore: deprecated_member_use
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          : SvgPicture.asset(
                                                              IconConstants
                                                                  .like,
                                                            ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "\$" +
                                          snapshot.data![index].price
                                              .toString() +
                                          "/day",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          155,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Text(
                                                snapshot.data![index].typeOfAdd,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: ColorConstants.colorGray,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                          Container(
                                            child: Text(
                                              "${snapshot.data![index].height.round()}in X ${snapshot.data![index].width.round()}in ${snapshot.data![index].sqfeet.round()}sqft",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: ColorConstants.colorGray,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 23,
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: ColorConstants.colorGray,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                snapshot
                                                    .data![index].tags.first,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.transparent,
                      );
                    },
                    itemCount: snapshot.data!.length),
              );
            } else {
              return Center(
                child: LoadingWidget(),
              );
            }
          },
        ));
  }
}
