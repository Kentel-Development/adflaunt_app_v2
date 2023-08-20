import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/widgets/listing/listing_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../product/widgets/headers/main_header.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: false, title: S.of(context).favorites),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        color: Colors.white,
        child: ValueListenableBuilder(
          valueListenable: Hive.box<List<String>>("favorites").listenable(),
          builder: (context, box, child) {
            final favorites = box.get("favorites", defaultValue: <String>[])!;
            if (favorites.length == 0) {
              return Center(
                child: Text(
                  S.of(context).youHaveNoFavoritesYet,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: ListingsAPI.getListing(favorites[index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListingList(listing: snapshot.data!);
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
