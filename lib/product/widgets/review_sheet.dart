// ignore_for_file: library_private_types_in_public_api

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class ReviewModalSheet extends StatefulWidget {
  const ReviewModalSheet({super.key});

  @override
  _ReviewModalSheetState createState() => _ReviewModalSheetState();
}

class _ReviewModalSheetState extends State<ReviewModalSheet> {
  double _rating = 0.0;
  String _comment = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).leaveAReview,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 40.0),
                  const SizedBox(width: 16.0),
                  Text(
                    _rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Slider(
                value: _rating,
                activeColor: Colors.amber,
                inactiveColor: Colors.amber.withOpacity(0.3),
                min: 0.0,
                max: 5.0,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                cursorColor: ColorConstants.colorPrimary,
                decoration: InputDecoration(
                  hintText: S.of(context).writeAComment,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.colorPrimary)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.colorPrimary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstants.colorPrimary, width: 2)),
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _comment = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.colorPrimary,
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'rating': _rating,
                    'comment': _comment,
                  });
                },
                child: Text(S.of(context).submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
