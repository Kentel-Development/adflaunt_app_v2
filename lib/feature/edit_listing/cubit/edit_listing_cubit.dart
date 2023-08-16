import 'dart:convert';
import 'dart:io';

import 'package:adflaunt/core/base/bloc_base.dart';
import 'package:adflaunt/core/constants/listing_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/core/extensions/date_parser_extension.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/services/upload.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'edit_listing_state.dart';

class EditListingCubit extends BaseBloc<EditListingState, EditListingState> {
  EditListingCubit(this.listing) : super(EditListingInitial());
  final Output listing;
  List<XFile> images = [];
  late List<XFile> newImages;
  late String title = listing.title;
  late String description = listing.description;
  late String height = listing.height.toString();
  late String width = listing.width.toString();
  bool cancelPolicy = false;
  late String states = listing.state;
  late String city = listing.city;
  late String country = listing.country;
  late String zip = listing.zipCode;
  late String? selectedSpaceType = listing.tags[0];
  late String? selectedAdType = listing.tags[1];
  late DateTime? installationDate = listing.checkIn.parseDate();
  late DateTime? removalDate = listing.checkOut.parseDate();
  TextEditingController tagsController = TextEditingController();
  late List<String> tags = listing.tags.sublist(2);
  late String price = "\$" + listing.price.toString();
  late int selectedCategory = ListingConstants.types.indexOf(listing.typeOfAdd);

  void addTag(String tag) {
    tags.add(tag);
    tagsController.clear();
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void removeTag(String tag) {
    tags.remove(tag);
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void changeCategory(int index) {
    selectedCategory = index;
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void selectSpaceType(String val) {
    selectedSpaceType = val;
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void selectAdType(String val) {
    selectedAdType = val;
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void changeInstallationDate(DateTime picked) {
    installationDate = picked;
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void changeRemovalDate(DateTime picked) {
    removalDate = picked;
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void changeCancelPolicy() {
    cancelPolicy = !cancelPolicy;
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void pickImage() async {
    final pickedFile = await ImagePicker().pickMultiImage(imageQuality: 1);
    if (pickedFile.length > 0) {
      if (pickedFile.length + images.length > 10) {
        newImages.addAll(pickedFile.sublist(0, (10 - newImages.length)));
        safeEmit(EditListingNotify());
        safeEmit(EditListingInitial());
      } else {
        newImages.addAll(pickedFile);
        safeEmit(EditListingNotify());
        safeEmit(EditListingInitial());
      }
    }
  }

  void orderImages(int oldIndex, int newIndex) {
    final element = newImages.removeAt(oldIndex);
    newImages.insert(newIndex, element);
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void removeImage(int index) {
    newImages.removeAt(index);
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void getImages() async {
    safeEmit(EditListingLoading());
    for (final image in listing.images) {
      final file = await ImageDownloader.downloadImage(image);
      images.add(XFile(file.path));
    }
    newImages = [...images];
    safeEmit(EditListingNotify());
    safeEmit(EditListingInitial());
  }

  void editListing(BuildContext context) async {
    safeEmit(EditListingLoading());
    final List<XFile> differentElements =
        newImages.where((element) => !images.contains(element)).toList();
    print(differentElements.toString());
    for (final element in differentElements) {
      final url = await UploadService.uploadImage(element.path);
      int index = newImages.indexOf(element);
      newImages.removeAt(index);
      newImages.insert(index, XFile(url, name: url));
    }
    for (final element in newImages) {
      print(element.name);
    }
    final response = (await ListingsAPI.editListing(
        listing.id!,
        newImages.map((e) => e.name).toList(),
        title,
        description,
        price,
        height,
        width,
        cancelPolicy,
        selectedSpaceType!,
        selectedAdType!,
        tags,
        installationDate!,
        removalDate!,
        selectedCategory,
        states,
        city,
        country,
        zip,
        listing));
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      json.addAll({"_id": listing.id});
      final output = Output.fromJson(json);
      Navigator.pop(context, output);
    } else {}
  }
}

class ImageDownloader {
  static Future<File> downloadImage(String name) async {
    final response =
        await http.get(Uri.parse(StringConstants.baseStorageUrl + name));
    final bytes = response.bodyBytes;
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/$name';
    final file = File(imagePath);
    await file.writeAsBytes(bytes);
    return file;
  }
}
