import 'package:adflaunt/feature/booking_list/booking_list.dart';
import 'package:adflaunt/feature/booking_list/host_page.dart';
import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AsHostList extends StatelessWidget {
  AsHostList({this.asHost, super.key});
  List<As>? asHost;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.transparent,
          ),
          itemCount: asHost!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => HostPage(
                      asHost![index],
                      asHost![index].data!.bookingId!,
                    ),
                  ),
                );
              },
              child: BookingList(
                listingData: asHost![index].listingData!,
                status: asHost![index].status,
              ),
            );
          },
        ),
      ),
    );
  }
}
