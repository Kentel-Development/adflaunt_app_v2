import 'dart:developer';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/booking_list/booking_list.dart';
import 'package:adflaunt/feature/booking_list/customer_page.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'host_page.dart';

class BookingListView extends StatefulWidget {
  const BookingListView({super.key});

  @override
  State<BookingListView> createState() => _BookingListViewState();
}

class _BookingListViewState extends State<BookingListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BookingService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final asHost = snapshot.data!.asHost;
            asHost!.removeWhere((element) => element.status == "Not found");
            final asCustomer = snapshot.data!.asCustomer;
            asCustomer!.removeWhere((element) => element.status == "Not found");
            log(snapshot.data.toString());
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  backgroundColor: ColorConstants.backgroundColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(104),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Header(
                              hasBackBtn: false, title: S.of(context).booking),
                        ),
                        TabBar(
                            indicatorColor: Colors.black,
                            labelColor: ColorConstants.colorPrimary,
                            tabs: [
                              Tab(
                                text: "As Host",
                              ),
                              Tab(
                                text: "As Customer",
                              ),
                            ])
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: GestureDetector(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.transparent,
                            ),
                            itemCount: asHost.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                        MaterialPageRoute<dynamic>(
                                          builder: (context) => HostPage(
                                            asHost[index],
                                            asHost[index].data!.bookingId!,
                                          ),
                                        ),
                                      )
                                      .then((value) => setState(() {}));
                                },
                                child: BookingList(
                                  listingData: asHost[index].listingData!,
                                  status: asHost[index].status,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.transparent,
                          ),
                          itemCount: asCustomer.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute<dynamic>(
                                        builder: (context) => CustomerPage(
                                          asCustomer: asCustomer[index],
                                        ),
                                      ),
                                    )
                                    .then((value) => setState(() {}));
                              },
                              child: BookingList(
                                listingData: asCustomer[index].listingData!,
                                status: asCustomer[index].status,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            );
          } else {
            return const Center(
              child: LoadingWidget(),
            );
          }
        });
  }
}
