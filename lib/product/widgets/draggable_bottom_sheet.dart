import 'package:adflaunt/feature/all_listings/all_listings.dart';
import 'package:adflaunt/feature/home/cubit/home_cubit.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/icon_constants.dart';
import '../../generated/l10n.dart';
import 'headers/common_heading.dart';
import 'listing/listing_grid.dart';
import 'listing/listing_list.dart';

int selectedView = 0;

class DraggableBottomSheet extends StatefulWidget {
  final Widget backgroundWidget;
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
  final String states;
  final String city;
  final String country;
  final String zip;
  DraggableBottomSheet({
    required this.backgroundWidget,
    required this.type,
    required this.category,
    required this.from,
    required this.to,
    required this.priceStart,
    required this.priceEnd,
    required this.lat,
    required this.lng,
    required this.states,
    required this.city,
    required this.country,
    required this.zip,
    required this.installationDate,
    required this.removalDate,
  });

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  bool isSwipeUp = false;
  bool status = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Colors.black26,
        width: size.width,
        child: Stack(
          children: [
            widget.backgroundWidget,
            AnimatedPositioned(
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 400),
                bottom: !isSwipeUp ? 0 : -constraints.maxHeight + 45,
                left: 0,
                right: 0,
                child: GestureDetector(
                    onPanEnd: (details) async {
                      print(details.velocity.pixelsPerSecond.dy.toString());
                      print(details.velocity.pixelsPerSecond.dx.toString());
                      if (details.velocity.pixelsPerSecond.dy > -100) {
                        setState(() {
                          isSwipeUp = true;
                        });

                        setState(() {
                          status = true;
                        });
                      } else {
                        setState(() {
                          isSwipeUp = false;
                        });

                        setState(() {
                          status = false;
                        });
                      }
                    },
                    child: SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: listingsBuilder())))
          ],
        ),
      );
    });
  }

  StatefulBuilder listingsBuilder() {
    return StatefulBuilder(builder: (context, state) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(212, 212, 216, 1),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: status ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return Center(
                                child: Text(
                                  state is HomeMapLoading
                                      ? "Loading..."
                                      : "${context.read<HomeCubit>().markers.length == 0 ? "No" : context.read<HomeCubit>().markers.length} Listings Found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: status ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  state(() {
                                    selectedView = 0;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: selectedView == 0
                                        ? Color.fromRGBO(212, 212, 216, 1)
                                        : Colors.white,
                                  ),
                                  child: SvgPicture.asset(IconConstants.grid),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  state(() {
                                    selectedView = 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: selectedView == 1
                                        ? Color.fromRGBO(212, 212, 216, 1)
                                        : Colors.white,
                                  ),
                                  child: SvgPicture.asset(
                                    IconConstants.list,
                                    // ignore: deprecated_member_use
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: ListingsAPI.listingsFilterer(
                                    widget.type,
                                    widget.category,
                                    widget.from,
                                    widget.to,
                                    widget.priceStart,
                                    widget.priceEnd,
                                    widget.lat,
                                    widget.lng,
                                    "",
                                    null,
                                    widget.states,
                                    widget.city,
                                    widget.country,
                                    widget.zip,
                                    widget.installationDate,
                                    widget.removalDate,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final list = snapshot
                                          .data!.output.reversed
                                          .toList();
                                      if (list.isEmpty) {
                                        return Column(
                                          children: [
                                            CommonHeading(
                                              headingText:
                                                  S.of(context).popularAdSpaces,
                                              hasBtn: false,
                                            ),
                                            Center(
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .noPopularListingsFound,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute<dynamic>(
                                                  builder: (context) {
                                                    return AllListingsView(
                                                      title: S
                                                          .of(context)
                                                          .popularAdSpaces,
                                                      type: widget.type,
                                                      category: widget.category,
                                                      from: widget.from,
                                                      to: widget.to,
                                                      priceStart:
                                                          widget.priceStart,
                                                      priceEnd: widget.priceEnd,
                                                      lat: widget.lat,
                                                      lng: widget.lng,
                                                      states: widget.states,
                                                      city: widget.city,
                                                      country: widget.country,
                                                      zip: widget.zip,
                                                      installationDate: widget
                                                          .installationDate,
                                                      removalDate:
                                                          widget.removalDate,
                                                    );
                                                  },
                                                ));
                                              },
                                              child: CommonHeading(
                                                headingText: S
                                                    .of(context)
                                                    .popularAdSpaces,
                                                onPress: false,
                                              ),
                                            ),
                                            selectedView == 0
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: SizedBox(
                                                      height: 200,
                                                      child: Row(
                                                          children: List.generate(
                                                              snapshot
                                                                          .data!
                                                                          .output
                                                                          .length >
                                                                      2
                                                                  ? 2
                                                                  : snapshot
                                                                      .data!
                                                                      .output
                                                                      .length,
                                                              (index) {
                                                        return Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 8,
                                                              left: 8,
                                                            ),
                                                            child: ListingGrid(
                                                              listing:
                                                                  list[index],
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                    ))
                                                : Column(
                                                    children: List.generate(
                                                        snapshot.data!.output
                                                                    .length >
                                                                2
                                                            ? 2
                                                            : snapshot.data!
                                                                .output.length,
                                                        (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 8,
                                                        ),
                                                        child: ListingList(
                                                          listing: list[index],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                          ],
                                        );
                                      }
                                    } else {
                                      return Center(child: Container());
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                FutureBuilder(
                                  future: ListingsAPI.listingsFilterer(
                                    widget.type,
                                    widget.category,
                                    widget.from,
                                    widget.to,
                                    widget.priceStart,
                                    widget.priceEnd,
                                    widget.lat,
                                    widget.lng,
                                    "",
                                    "20",
                                    widget.states,
                                    widget.city,
                                    widget.country,
                                    widget.zip,
                                    widget.installationDate,
                                    widget.removalDate,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final list =
                                          snapshot.data!.output.toList();
                                      if (list.isEmpty) {
                                        return Column(
                                          children: [
                                            CommonHeading(
                                              headingText:
                                                  S.of(context).adSpacesNearYou,
                                              hasBtn: false,
                                            ),
                                            Center(
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .noNearbyListingsFound,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute<dynamic>(
                                                  builder: (context) {
                                                    return AllListingsView(
                                                      title: S
                                                          .of(context)
                                                          .adSpacesNearYou,
                                                      type: widget.type,
                                                      category: widget.category,
                                                      from: widget.from,
                                                      to: widget.to,
                                                      priceStart:
                                                          widget.priceStart,
                                                      priceEnd: widget.priceEnd,
                                                      lat: widget.lat,
                                                      lng: widget.lng,
                                                      states: widget.states,
                                                      city: widget.city,
                                                      country: widget.country,
                                                      zip: widget.zip,
                                                      installationDate: widget
                                                          .installationDate,
                                                      removalDate:
                                                          widget.removalDate,
                                                    );
                                                  },
                                                ));
                                              },
                                              child: CommonHeading(
                                                headingText: S
                                                    .of(context)
                                                    .adSpacesNearYou,
                                                onPress: false,
                                              ),
                                            ),
                                            selectedView == 0
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: SizedBox(
                                                      height: 200,
                                                      child: Row(
                                                          children: List.generate(
                                                              snapshot
                                                                          .data!
                                                                          .output
                                                                          .length >
                                                                      2
                                                                  ? 2
                                                                  : snapshot
                                                                      .data!
                                                                      .output
                                                                      .length,
                                                              (index) {
                                                        return Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 8,
                                                              left: 8,
                                                            ),
                                                            child: ListingGrid(
                                                              listing:
                                                                  list[index],
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                    ))
                                                : Column(
                                                    children: List.generate(
                                                        snapshot.data!.output
                                                                    .length >
                                                                2
                                                            ? 2
                                                            : snapshot.data!
                                                                .output.length,
                                                        (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 8,
                                                        ),
                                                        child: ListingList(
                                                          listing: list[index],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                          ],
                                        );
                                      }
                                    } else {
                                      return Center(child: LoadingWidget());
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                FutureBuilder(
                                  future: ListingsAPI.listingsFilterer(
                                    widget.type,
                                    widget.category,
                                    widget.from,
                                    widget.to,
                                    widget.priceStart,
                                    widget.priceEnd,
                                    widget.lat,
                                    widget.lng,
                                    "Digital",
                                    null,
                                    widget.states,
                                    widget.city,
                                    widget.country,
                                    widget.zip,
                                    widget.installationDate,
                                    widget.removalDate,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final list =
                                          snapshot.data!.output.toList();
                                      if (list.isEmpty) {
                                        return Column(
                                          children: [
                                            CommonHeading(
                                              headingText:
                                                  S.of(context).digitalAds,
                                              hasBtn: false,
                                            ),
                                            Center(
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .noDigitalListingsFound,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute<dynamic>(
                                                  builder: (context) {
                                                    return AllListingsView(
                                                      title: S
                                                          .of(context)
                                                          .digitalAds,
                                                      type: widget.type,
                                                      category: widget.category,
                                                      from: widget.from,
                                                      to: widget.to,
                                                      priceStart:
                                                          widget.priceStart,
                                                      priceEnd: widget.priceEnd,
                                                      lat: widget.lat,
                                                      lng: widget.lng,
                                                      states: widget.states,
                                                      city: widget.city,
                                                      country: widget.country,
                                                      zip: widget.zip,
                                                      installationDate: widget
                                                          .installationDate,
                                                      removalDate:
                                                          widget.removalDate,
                                                    );
                                                  },
                                                ));
                                              },
                                              child: CommonHeading(
                                                headingText:
                                                    S.of(context).digitalAds,
                                              ),
                                            ),
                                            selectedView == 0
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: SizedBox(
                                                      height: 200,
                                                      child: Row(
                                                          children: List.generate(
                                                              snapshot
                                                                          .data!
                                                                          .output
                                                                          .length >
                                                                      2
                                                                  ? 2
                                                                  : snapshot
                                                                      .data!
                                                                      .output
                                                                      .length,
                                                              (index) {
                                                        return Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 8,
                                                              left: 8,
                                                            ),
                                                            child: ListingGrid(
                                                              listing:
                                                                  list[index],
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                    ))
                                                : Column(
                                                    children: List.generate(
                                                        snapshot.data!.output
                                                                    .length >
                                                                2
                                                            ? 2
                                                            : snapshot.data!
                                                                .output.length,
                                                        (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 8,
                                                        ),
                                                        child: ListingList(
                                                          listing: list[index],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                          ],
                                        );
                                      }
                                    } else {
                                      return Center(child: Container());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    });
  }
}
