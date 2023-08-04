import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/core/constants/padding_constants.dart';
import 'package:adflaunt/feature/login/login_view.dart';
import 'package:adflaunt/feature/register/register_view.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(IconConstants.onboarding, fit: BoxFit.cover),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Image.asset(IconConstants.logo),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Find a space. Fulfill your vision.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorPrimary,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: PaddingConstants.largePadding,
                          right: PaddingConstants.largePadding,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: CommonBtn(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (context) => RegisterView(),
                                ),
                              );
                            },
                            text: 'Sign Up',
                            backgroundColor: ColorConstants.colorPrimary,
                            textColor: ColorConstants.colorSecondary,
                            foregroundColor: ColorConstants.colorPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: PaddingConstants.largePadding,
                          right: PaddingConstants.largePadding,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: CommonBtn(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (context) => LoginView(),
                                ),
                              );
                            },
                            text: 'Log In',
                            backgroundColor: ColorConstants.colorSecondary,
                            textColor: ColorConstants.colorPrimary,
                            foregroundColor: ColorConstants.colorPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Continue as a guest',
                              style: TextStyle(
                                color: ColorConstants.colorTertiary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              IconConstants.arrowRight,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
