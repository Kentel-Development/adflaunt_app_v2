import 'dart:convert';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/base/bloc_base.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/core/extensions/replace_non_ascii.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/services/location.dart';
import 'package:adflaunt/product/services/post_ad.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'post_ad_state.dart';

class PostAdCubit extends BaseBloc<PostAdState, PostAdState> {
  PostAdCubit() : super(PostAdInitial());
  int selectedCategory = 0;
  LatLng? currentLocation;
  GoogleMapController? mapController;
  Set<Marker> markers =
      <Marker>{}; // Set<Marker>.of(context.watch<PostAdCubit>().markers)
  Marker? searchMarker;
  TextEditingController searchController = TextEditingController();
  String states = "";
  String city = "";
  String country = "";
  String zip = "";
  String? selectedSpaceType;
  String? selectedAdType;
  DateTime? installationDate;
  DateTime? removalDate;
  TextEditingController tagsController = TextEditingController();
  List<String> tags = [];
  String price = "";
  String title = "";
  String description = "";
  String height = "";
  String width = "";
  bool cancelPolicy = false;
  List<XFile> images = [];
  Output? output;
  void getLocation() {
    LocationService().getLocation().then((value) async {
      currentLocation = LatLng(value.latitude, value.longitude);
      searchMarker = Marker(
        markerId: const MarkerId('searchLocation'),
        position: LatLng(value.latitude, value.longitude),
        icon: (await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: const Size(32, 24), devicePixelRatio: 1.0),
            IconConstants.marker)),
      );
    });
  }

  void postAd() async {
    safeEmit(PostAdLoading());
    try {
      final response = await ListingsAPI.postListing(
          title,
          price,
          currentLocation!.latitude.toString(),
          currentLocation!.longitude.toString(),
          states,
          city,
          country,
          zip,
          0,
          0,
          false,
          height,
          width,
          selectedCategory,
          "",
          cancelPolicy.toString(),
          DateFormat(StringConstants.dateFormat).format(installationDate!),
          DateFormat(StringConstants.dateFormat).format(removalDate!),
          tags,
          images,
          [],
          "",
          description,
          cancelPolicy,
          Hive.box<ProfileAdapter>("user").get("userData")!,
          selectedSpaceType!,
          selectedAdType!);
      output =
          Output.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      safeEmit(PostAdSuccess());
    } catch (e) {
      safeEmit(PostListingError(e.toString()));
    }
  }

  void takeImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 1);
    if (pickedFile != null) {
      images.add(pickedFile);
      safeEmit(PostAdNotify());
      safeEmit(PostAdInitial());
    }
  }

  void pickImage() async {
    final pickedFile = await ImagePicker().pickMultiImage(imageQuality: 1);
    if (pickedFile.length > 0) {
      if (pickedFile.length + images.length > 10) {
        images.addAll(pickedFile.sublist(0, (10 - images.length)));
        safeEmit(PostAdNotify());
        safeEmit(PostAdInitial());
      } else {
        images.addAll(pickedFile);
        safeEmit(PostAdNotify());
        safeEmit(PostAdInitial());
      }
    }
  }

  void orderImages(int oldIndex, int newIndex) {
    final element = images.removeAt(oldIndex);
    images.insert(newIndex, element);
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void removeImage(int index) {
    images.removeAt(index);
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void changeCancelPolicy() {
    cancelPolicy = !cancelPolicy;
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void addTag(String tag) {
    tags.add(tag);
    tagsController.clear();
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void removeTag(String tag) {
    tags.remove(tag);
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void changeCategory(int index) {
    selectedCategory = index;
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void selectSpaceType(String val) {
    selectedSpaceType = val;
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void selectAdType(String val) {
    selectedAdType = val;
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void changeInstallationDate(DateTime picked) {
    installationDate = picked;
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  void changeRemovalDate(DateTime picked) {
    removalDate = picked;
    safeEmit(PostAdNotify());
    safeEmit(PostAdInitial());
  }

  Future<void> searchAddress(String address) async {
    try {
      List<Location> locations =
          await locationFromAddress(address.replaceNonAscii());
      Location location = locations.first;
      searchMarker = Marker(
        markerId: const MarkerId('searchLocation'),
        position: LatLng(location.latitude, location.longitude),
      );
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 15,
          ),
        ),
      );
      safeEmit(PostAdNotify());
      safeEmit(PostAdInitial());
    } catch (e) {
      safeEmit(PostListingError(e.toString()));
    }
  }

  bool verify(int index) {
    if (index == 2) {
      if (states == "" || city == "" || country == "" || zip == "") {
        return false;
      } else {
        return true;
      }
    } else if (index == 3) {
      if (selectedAdType == null ||
          selectedSpaceType == null ||
          installationDate == null ||
          removalDate == null) {
        return false;
      } else {
        return true;
      }
    } else if (index == 4) {
      if (title == "" ||
          description == "" ||
          price == "" ||
          width == "" ||
          height == "" ||
          images.length == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
