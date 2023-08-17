import 'dart:async';
import 'dart:math';

import 'package:adflaunt/core/base/bloc_base.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:equatable/equatable.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/utils/spherical_utils.dart';
import 'package:interactive_maps_marker/interactive_maps_marker.dart';

import '../../../core/constants/listing_constants.dart';
import '../../../product/models/listings/results.dart';

part 'home_state.dart';

class HomeCubit extends BaseBloc<HomeState, HomeState> {
  HomeCubit() : super(HomeInitial());
  final List<MarkerItem> markers = [];
  List<Output> listing = [];
  LatLng mapPosition = LatLng(0, 0);
  final controller = InteractiveMapsController();
  Completer<GoogleMapController> _controller = Completer();
  String lat = "";
  String long = "";
  String km = "1";
  void onMapCreated(List<Output> listings) async {
    safeEmit(HomeMapLoading());

    await addMarker(listings);
    safeEmit(HomeMapUpdated());
  }

  Future<bool> addMarker(List<Output> listings) async {
    clearMarkers();
    listing = listings;
    try {
      listings.forEach((element) async {
        markers.add(MarkerItem(
          id: listings.indexOf(element),
          latitude: element.lat,
          longitude: element.long,
        ));
      });
      return true;
    } catch (e) {
      throw e;
    }
  }

  void clearMarkers() {
    markers.clear();
  }

  void completeMap() async {
    await Future<dynamic>.delayed(Duration(seconds: 1));
    if (controller.getMapController() != null) {
      _controller.complete(controller.getMapController()!);
    }
  }

  void onMapMove(int category) async {
    //log(lat.toString() + " / " + long.toString());
    safeEmit(HomeMapLoading());
    final bounds = await controller.getMapController()!.getVisibleRegion();
    LatLng northeast = bounds.northeast;
    LatLng southwest = bounds.southwest;
    Point center = Point((northeast.latitude + southwest.latitude) / 2,
        (northeast.longitude + southwest.longitude) / 2);
    Point northEastPoint = Point(northeast.latitude, northeast.longitude);
    final radius =
        SphericalUtils.computeDistanceBetween(center, northEastPoint) / 1000;

    try {
      final listings = await ListingsAPI.listingsFilterer(
          null,
          ListingConstants.types[category],
          null,
          null,
          null,
          null,
          lat.toString(),
          long.toString(),
          null,
          radius.toString());

      await addMarker(listings);

      safeEmit(HomeMapUpdated());
    } catch (e) {
      safeEmit(HomeMapError(message: e.toString()));
    }
  }
}
