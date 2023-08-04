import 'package:adflaunt/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/icon_constants.dart';
import '../../generated/l10n.dart';
import '../models/listings/results.dart';
import 'headers/common_heading.dart';
import 'listing/listing_grid.dart';
import 'listing/listing_list.dart';

int selectedView = 0;

class DraggableBottomSheet extends StatefulWidget {
  final Widget backgroundWidget;
  final List<Output> listing;
  DraggableBottomSheet({
    required this.backgroundWidget,
    required this.listing,
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
    return Container(
      color: Colors.black26,
      width: size.width,
      child: Stack(
        children: [
          widget.backgroundWidget,
          AnimatedPositioned(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 400),
              top: !isSwipeUp ? size.height * 0 : size.height * 0.48,
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
                  child: listingsBuilder(widget.listing)))
        ],
      ),
    );
  }

  StatefulBuilder listingsBuilder(List<Output> listing) {
    final size = MediaQuery.of(context).size;
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
          width: size.width,
          height: size.height * 0.529,
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
                          listing.length > 1
                              ? Expanded(
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CommonHeading(
                                        headingText:
                                            S.of(context).popularAdSpaces,
                                      ),
                                      selectedView == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Expanded(
                                                  child: ListingGrid(
                                                    listing: listing[0],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: ListingGrid(
                                                    listing: listing[1],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                ListingList(
                                                  listing: listing[0],
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                ListingList(
                                                  listing: listing[1],
                                                ),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CommonHeading(
                                        headingText:
                                            S.of(context).popularAdSpaces,
                                      ),
                                      selectedView == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Expanded(
                                                  child: ListingGrid(
                                                    listing: listing[0],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: ListingGrid(
                                                    listing: listing[1],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                ListingList(
                                                  listing: listing[0],
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                ListingList(
                                                  listing: listing[1],
                                                ),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CommonHeading(
                                        headingText:
                                            S.of(context).popularAdSpaces,
                                      ),
                                      selectedView == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Expanded(
                                                  child: ListingGrid(
                                                    listing: listing[0],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: ListingGrid(
                                                    listing: listing[1],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                ListingList(
                                                  listing: listing[0],
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                ListingList(
                                                  listing: listing[1],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Text("No Listings Found"),
                                  ),
                                )
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
