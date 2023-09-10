import 'package:flutter/material.dart';

class CommonHeading extends StatelessWidget {
  final bool hasSpacing;
  final bool hasMargin;
  final String headingText;
  final bool hasBtn;
  final String hasBtnText;
  final dynamic onPress;
  final bool hasNavigat;
  const CommonHeading({
    Key? key,
    this.hasSpacing = true,
    this.hasMargin = true,
    this.headingText = '',
    this.hasBtn = true,
    this.hasBtnText = 'View all',
    this.onPress,
    this.hasNavigat = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hasSpacing ? 20 : 0),
      margin: EdgeInsets.only(bottom: hasMargin ? 23 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              headingText,
              style: TextStyle(
                color: const Color.fromRGBO(12, 12, 38, 1),
                fontSize: 18,
                letterSpacing: -0.02,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          hasBtn
              ? Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      hasBtnText,
                      style: TextStyle(
                        color: const Color.fromRGBO(119, 118, 130, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5.67),
                        child: const Icon(Icons.arrow_right))
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
