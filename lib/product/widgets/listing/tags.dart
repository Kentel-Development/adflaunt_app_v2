import 'package:flutter/material.dart';

import '../../../feature/listing_details/listing_details_view.dart';

class Tags extends StatelessWidget {
  const Tags({
    super.key,
    required this.widget,
  });

  final ListingDetailsView widget;

  @override
  Widget build(BuildContext context) {
    final tags = widget.listing.tags;
    tags.removeAt(0);
    tags.removeAt(0);
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Divider(),
        SizedBox(
          height: 6,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Tags",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
                .map(
                  (e) => Chip(
                    label: Text(
                      e,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(224, 224, 227, 1),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
