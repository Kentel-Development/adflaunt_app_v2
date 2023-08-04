import 'package:adflaunt/core/constants/font_size_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({
    required this.onPressed,
    required this.text,
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.loading = false,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: PaddingConstants.getPadding(PaddingEnum.medium), // 16),
          vertical: PaddingConstants.getPadding(PaddingEnum.small), // 8),
        ),
      ),
      child: loading
          ? SizedBox(
              height: 20,
              width: 40,
              child: const LoadingIndicator(
                  colors: [Colors.white],
                  indicatorType: Indicator.ballPulseSync))
          : Text(
              text,
              style: TextStyle(
                fontSize: FontSizeConstants.medium,
                color: textColor,
                fontFamily: 'Poppins',
              ),
            ),
    );
  }
}
