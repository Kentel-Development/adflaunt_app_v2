import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/home/cubit/home_cubit.dart';
import 'package:adflaunt/feature/listing_details/listing_details_view.dart';
import 'package:adflaunt/feature/profile/profile_view.dart';
import 'package:adflaunt/feature/search/search_view.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/services/location.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interactive_maps_marker/interactive_maps_marker.dart';

import '../../core/constants/listing_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../generated/l10n.dart';
import '../../product/widgets/category_tab.dart';
import '../../product/widgets/draggable_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedCategory = 1;
  LatLng? currentLocation;
  Future<List<Output>>? listings;
  int? type;
  String? from;
  String? to;
  String? priceStart;
  String? priceEnd;
  String? lat;
  String? lng;
  String? text;
  DateTime? installationDate;
  DateTime? removalDate;
  String states = '';
  String city = '';
  String country = '';
  String zip = '';
  @override
  void initState() {
    LocationService().getLocation().then((value) {
      setState(() {
        lat = value.latitude.toString();
        lng = value.longitude.toString();
        currentLocation = value;
      });
    }).catchError((Object e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String movedLat = "";
  String movedLng = "";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit()..completeMap(),
        child: Column(
          children: [
            SafeArea(child: buildHeader(context)),
            Padding(
              padding: const EdgeInsets.all(PaddingConstants.mediumPadding),
              child: SizedBox(
                height: 48,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SearchView())).then((value) {
                      if (value != null) {
                        setState(() {
                          text = value["location"].toString();
                          from = value["sizeStart"].toString();
                          to = value["sizeEnd"].toString();
                          priceStart = value["priceStart"].toString();
                          priceEnd = value["priceEnd"].toString();
                          lat = value["lat"].toString();
                          lng = value["lng"].toString();
                          installationDate =
                              value["installationDate"] as DateTime?;
                          removalDate = value["removalDate"] as DateTime?;
                          states = value["states"].toString();
                          city = value["city"].toString();
                          country = value["country"].toString();
                          zip = value["zip"].toString();
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(IconConstants.search),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  text ?? S.of(context).enterLocation,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.grey500,
                                      fontFamily: "Poppins"),
                                ),
                              )
                            ],
                          ),
                        ),
                        text != null
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    text = null;
                                    from = null;
                                    to = null;
                                    priceStart = null;
                                    priceEnd = null;
                                    lat = currentLocation!.latitude.toString();
                                    lng = currentLocation!.longitude.toString();
                                    installationDate = null;
                                    removalDate = null;
                                    states = '';
                                    city = '';
                                    country = '';
                                    zip = '';
                                  });
                                },
                                child: Icon(Icons.close))
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildCategoryRow(),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: ListingsAPI.listingsFilterer(
                    type,
                    ListingConstants.types[selectedCategory],
                    from,
                    to,
                    priceStart,
                    priceEnd,
                    lat,
                    lng,
                    "",
                    null,
                    city,
                    states,
                    country,
                    zip,
                    installationDate,
                    removalDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      !snapshot.hasData ||
                      currentLocation == null) {
                    return Expanded(
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    );
                  } else {
                    context
                        .read<HomeCubit>()
                        .onMapCreated(snapshot.data!.output);

                    return Expanded(
                      child: DraggableBottomSheet(
                        backgroundWidget: BlocConsumer<HomeCubit, HomeState>(
                          listener: (context, state) {
                            if (state is HomeMapError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(state.message),
                              ));
                            }
                          },
                          builder: (context, state) {
                            return Container(
                              color: ColorConstants.backgroundColor,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                child: InteractiveMapsMarker(
                                  itemHeight: 80,
                                  itemPadding:
                                      EdgeInsets.only(left: 50, bottom: 50),
                                  onCameraMove: (p0) {
                                    log("onCameraMove + $p0");
                                    context.read<HomeCubit>().lat =
                                        p0.target.latitude.toString();
                                    context.read<HomeCubit>().long =
                                        p0.target.longitude.toString();
                                    context.read<HomeCubit>().km =
                                        p0.zoom.toString();
                                  },
                                  onCameraIdle: () {
                                    log("onCameraIdle");
                                    context
                                        .read<HomeCubit>()
                                        .onMapMove(selectedCategory);
                                  },
                                  center: LatLng(
                                    double.parse(lat ??
                                        currentLocation!.latitude.toString()),
                                    double.parse(lng ??
                                        currentLocation!.longitude.toString()),
                                  ),
                                  items: context.read<HomeCubit>().markers,
                                  itemBuilder: (context, index) {
                                    final listing = context
                                        .read<HomeCubit>()
                                        .listing[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                                builder: (context) =>
                                                    ListingDetailsView(
                                                      listing: listing,
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: EdgeInsets.only(right: 24),
                                        child: Row(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: StringConstants
                                                        .baseStorageUrl +
                                                    context
                                                        .read<HomeCubit>()
                                                        .listing[index]
                                                        .images
                                                        .first,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(listing.title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall),
                                                    Text(
                                                        "\$" +
                                                            listing.price
                                                                .toString() +
                                                            "/" +
                                                            S.of(context).day,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall),
                                                    Expanded(
                                                      child: Text(
                                                          listing.description),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  controller:
                                      context.read<HomeCubit>().controller,
                                ),
                              ),
                            );
                          },
                        ),
                        type: type,
                        category: ListingConstants.types[selectedCategory],
                        from: from,
                        to: to,
                        priceStart: priceStart,
                        priceEnd: priceEnd,
                        lat: lat,
                        lng: lng,
                        states: states,
                        city: city,
                        country: country,
                        zip: zip,
                        installationDate: installationDate,
                        removalDate: removalDate,
                      ),
                    );
                  }
                }),
          ],
        ));
  }

  Container previewListings() {
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
      width: double.infinity,
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
        ],
      ),
    );
  }

  Padding buildCategoryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PaddingConstants.mediumPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = 1;
                });
              },
              child:
                  CategoryTab(category: 0, isSelected: selectedCategory == 1)),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = 0;
              });
            },
            child: CategoryTab(
              category: 1,
              isSelected: selectedCategory == 0,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = 2;
              });
            },
            child: CategoryTab(
              category: 2,
              isSelected: selectedCategory == 2,
            ),
          )
        ],
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(PaddingConstants.mediumPadding),
            child: Text(
              S.of(context).whereAreYouLookingToAdvertise,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
            ),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: Hive.box<ProfileAdapter>('user').listenable(),
            builder: (context, Box<ProfileAdapter> box, child) {
              final userData = box.get('userData')!;
              return Padding(
                padding: const EdgeInsets.only(
                    right: PaddingConstants.mediumPadding),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[400],
                  child: userData.profileImage == null ||
                          userData.profileImage == ""
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute<dynamic>(builder: (context) {
                              return ProfileView();
                            }));
                          },
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute<dynamic>(builder: (context) {
                              return ProfileView();
                            }));
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[400],
                            backgroundImage: CachedNetworkImageProvider(
                              StringConstants.baseStorageUrl +
                                  userData.profileImage!.toString(),
                            ),
                          ),
                        ),
                ),
              );
            })
      ],
    );
  }
}
