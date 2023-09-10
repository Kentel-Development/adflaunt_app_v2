import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/feature/booking_list/booking_list.dart';
import 'package:adflaunt/feature/booking_list/customer_page.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class BookingListView extends StatefulWidget {
  const BookingListView({super.key});

  @override
  State<BookingListView> createState() => _BookingListViewState();
}

class _BookingListViewState extends State<BookingListView> {
  List<Widget> tabs = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BookingService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final asCustomer = snapshot.data!.asCustomer;
            asCustomer!.removeWhere((element) => element.status == "Not found");
            final upcoming = asCustomer
                .where((element) => element.status != "completed")
                .toList();
            final completed = asCustomer
                .where((element) => element.status == "completed")
                .toList();
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  backgroundColor: ColorConstants.backgroundColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(114),
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
                                text: S.of(context).upcoming,
                              ),
                              Tab(
                                text: S.of(context).completed,
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      upcoming.length == 0
                          ? Center(
                              child: Text(
                                S.of(context).noUpcomingBookings,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                final booking = upcoming[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (context) => CustomerPage(
                                          asCustomer: booking,
                                        ),
                                      ),
                                    );
                                  },
                                  child: BookingList(
                                    listingData: booking.listingData!,
                                    status: booking.status,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: upcoming.length),
                      completed.length == 0
                          ? Center(
                              child: Text(
                                S.of(context).noCompletedBookings,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                final booking = completed[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (context) => CustomerPage(
                                          asCustomer: booking,
                                        ),
                                      ),
                                    );
                                  },
                                  child: BookingList(
                                    listingData: booking.listingData!,
                                    status: booking.status,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: completed.length),
                    ],
                  )),
            );
          } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(104),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      Header(hasBackBtn: false, title: S.of(context).booking),
                ),
              ),
              backgroundColor: ColorConstants.backgroundColor,
              body: const Center(
                child: LoadingWidget(),
              ),
            );
          }
        });
  }
}
