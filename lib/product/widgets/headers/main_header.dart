import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/icon_constants.dart';

class Header extends StatelessWidget {
  final String? title;
  final bool hasBackBtn;
  final String? rightIcon;
  final void Function()? onLeftIconTap;
  const Header(
      {Key? key,
      this.title,
      this.hasBackBtn = false,
      this.rightIcon,
      this.onLeftIconTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.backgroundColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      leading: hasBackBtn
          ? IconButton(
              onPressed: () {
                if (onLeftIconTap == null) {
                  Navigator.pop(context);
                } else {
                  onLeftIconTap!();
                }
              },
              icon: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      IconConstants.arrowLeft,
                      width: 11,
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      titleSpacing: 0.0,
      title: Text(
        title!,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(12, 12, 38, 1),
          letterSpacing: -0.02,
        ),
      ),
    );
  }
}
