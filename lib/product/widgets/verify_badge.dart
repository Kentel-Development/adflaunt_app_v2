import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyBadge extends StatelessWidget {
  const VerifyBadge({required this.isVerified, super.key});
  final bool isVerified;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isVerified
            ? Color.fromRGBO(205, 255, 197, 1)
            : Color.fromRGBO(255, 184, 201, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 36,
      width: isVerified ? 94 : 123,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isVerified ? IconConstants.check_ring : IconConstants.cross_ring,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              isVerified ? 'Verified' : 'Not Verified',
              style: TextStyle(
                color: isVerified
                    ? Color.fromRGBO(9, 140, 38, 1)
                    : Color.fromRGBO(221, 27, 73, 1),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
