import 'dart:developer';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/search/filter_view.dart';
import 'package:adflaunt/product/models/predictions.dart';
import 'package:adflaunt/product/services/place_autocomplete.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:async';
import '../../core/constants/icon_constants.dart';
import '../../generated/l10n.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  Predictions? predictions;
  Timer? debounce;
  SfRangeValues inchesValues = SfRangeValues(0, 100);
  SfRangeValues priceValues = SfRangeValues(0, 200);
  String? spaceType;
  String? adType;
  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 600), () {
      PlaceAutocompleteService.autocomplete(query).then((value) {
        setState(() {
          predictions = value;
        });
      });
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: 'Search Spaces'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: onSearchChanged,
                    controller: searchController,
                    cursorColor: ColorConstants.colorTertiary,
                    style: TextStyle(
                        color: ColorConstants.colorTertiary,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: S.of(context).enterLocation,
                      prefixIcon: SvgPicture.asset(
                        IconConstants.search,
                        // ignore: deprecated_member_use
                        color: ColorConstants.colorTertiary,
                        fit: BoxFit.scaleDown,
                      ),
                      fillColor: ColorConstants.colorSecondary,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.grey400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      IconConstants.filter,
                      fit: BoxFit.scaleDown,
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(context,
                          MaterialPageRoute<dynamic>(
                        builder: (context) {
                          return FilterView();
                        },
                      ));
                      if (result != null) {
                        setState(() {
                          inchesValues = result["size"] as SfRangeValues;
                          priceValues = result["price"] as SfRangeValues;
                          spaceType = result["spaceType"] as String?;
                          adType = result["adType"] as String?;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
            searchController.text.length > 0 &&
                    (predictions != null &&
                        predictions!.predictions!.length > 0)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: predictions!.predictions!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            final latLng = await PlaceAutocompleteService
                                .placeToCoordinates(
                                    predictions!.predictions![index].placeId!);
                            log(latLng["lat"].toString());
                            log(latLng["lng"].toString());
                            Navigator.pop(
                              context,
                              {
                                "lat": latLng["lat"],
                                "lng": latLng["lng"],
                                "location": predictions!
                                    .predictions![index].description,
                                "adType": adType,
                                "spaceType": spaceType,
                                "priceStart": priceValues.start,
                                "priceEnd": priceValues.end,
                                "sizeStart": inchesValues.start,
                                "sizeEnd": inchesValues.end,
                              },
                            );
                            List<String> searches =
                                Hive.box<List<String>>("recentSearch")
                                    .get("searches", defaultValue: [])!;

                            searches.insert(
                                0,
                                predictions!.predictions![index].placeId! +
                                    "|-|" +
                                    predictions!
                                        .predictions![index].description!);
                            Hive.box<List<String>>("recentSearch")
                                .put("searches", searches);
                          },
                          title: Text(
                              predictions!.predictions![index].description!),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.of(context).recentSearches,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: Hive.box<List<String>>("recentSearch")
                              .get("searches", defaultValue: [])!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                List<String> list =
                                    Hive.box<List<String>>("recentSearch")
                                        .get("searches", defaultValue: [])!;
                                final latLng = await PlaceAutocompleteService
                                    .placeToCoordinates(
                                        list[index].split("|-|")[0]);
                                log(latLng["lat"].toString());
                                log(latLng["lng"].toString());
                                Navigator.pop(
                                  context,
                                  {
                                    "location": list[index].split("|-|")[1],
                                    "lat": latLng["lat"],
                                    "lng": latLng["lng"],
                                    "adType": adType,
                                    "spaceType": spaceType,
                                    "priceStart": priceValues.start,
                                    "priceEnd": priceValues.end,
                                    "sizeStart": inchesValues.start,
                                    "sizeEnd": inchesValues.end,
                                  },
                                );
                                list.insert(0, list.removeAt(index));
                                Hive.box<List<String>>("recentSearch")
                                    .put("searches", list);
                              },
                              title: Text(Hive.box<List<String>>("recentSearch")
                                  .get("searches", defaultValue: [])![
                                      index].split("|-|")[1]),
                            );
                          },
                        ),
                      )
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
