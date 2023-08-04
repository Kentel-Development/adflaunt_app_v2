import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/font_size_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:flutter/material.dart';

class ImgButton extends StatelessWidget {
  const ImgButton({
    required this.onPressed,
    required this.text,
    required this.img,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(
            color: Color.fromRGBO(217, 217, 217, 1),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: PaddingConstants.getPadding(PaddingEnum.medium), // 16),
          vertical: PaddingConstants.getPadding(PaddingEnum.small), // 8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: ColorConstants.colorPrimary,
              fontSize: FontSizeConstants.medium,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
