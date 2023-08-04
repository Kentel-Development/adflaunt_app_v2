import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/listing/listing_list.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../product/models/listings/results.dart';

class MyListingsView extends StatelessWidget {
  const MyListingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Header(hasBackBtn: true, title: S.of(context).myListings),
          ),
        ),
        body: FutureBuilder<List<Output>>(
            future: ListingsAPI.getUserListings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        S.of(context).editOrViewYourAdListingsHere,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                        itemBuilder: (context, index) {
                          return ListingList(
                            listing: snapshot.data![index],
                            isMyListing: true,
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: LoadingWidget(),
                );
              }
            }));
  }
}
