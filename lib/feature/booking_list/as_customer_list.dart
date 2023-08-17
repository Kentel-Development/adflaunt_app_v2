import 'package:adflaunt/feature/booking_list/booking_list.dart';
import 'package:adflaunt/feature/booking_list/customer_page.dart';
import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AsCustomerList extends StatelessWidget {
  AsCustomerList({this.asCustomer, super.key});
  List<As>? asCustomer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.transparent,
        ),
        itemCount: asCustomer!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (context) => CustomerPage(
                    asCustomer: asCustomer![index],
                  ),
                ),
              );
            },
            child: BookingList(
              listingData: asCustomer![index].listingData!,
              status: asCustomer![index].status,
            ),
          );
        },
      ),
    );
  }
}
