import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CurvedCircularProgressIndicator(
          backgroundColor: ColorConstants.colorGray,
          color: ColorConstants.colorPrimary,
          strokeWidth: 14,
        ),
      ),
    );
  }
}
