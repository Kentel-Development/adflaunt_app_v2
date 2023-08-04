import 'dart:io';

import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/l10n.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? controller;
  void _initializeCameraController(CameraDescription cameraDescription) {
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );

    controller!.initialize().then((value) {
      controller!.value = controller!.value.copyWith(
        previewSize: const Size(300, 344),
      );
    });
    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    if (controller!.value.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).errorInitializingCamera),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      controller = CameraController(value[0], ResolutionPreset.max);
      _initializeCameraController(value[0]);
    });
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  List<File> images = [];
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 84;
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    } else {
      return Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            Stack(
              children: [
                Image.asset(
                  IconConstants.photo_background,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 72.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            images.length == 1
                                ? Text(S.of(context).backOfId,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600))
                                : Text(S.of(context).frontOfId,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600)),
                            SizedBox(height: 16),
                            Text(
                                images.length == 1
                                    ? S
                                        .of(context)
                                        .fitTheBackOfYourIdWithinTheFrame
                                    : S
                                        .of(context)
                                        .fitTheFrontOfYourIdWithinTheFrame,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Center(
                          child: SizedBox(
                            width: size,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(children: [
                                CameraPreview(
                                  controller!,
                                ),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: SvgPicture.asset(
                                        IconConstants.top_left)),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: SvgPicture.asset(
                                        IconConstants.top_right)),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: SvgPicture.asset(
                                        IconConstants.bottom_left)),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: SvgPicture.asset(
                                        IconConstants.bottom_right)),
                              ]),
                            ),
                          ),
                        ),
                        StatefulBuilder(builder: (context, state) {
                          return GestureDetector(
                              onTap: () {
                                if (!loading) {
                                  state(() {
                                    loading = true;
                                  });
                                  if (images.length == 1) {
                                    controller!.takePicture().then((value) {
                                      images.add(File(value.path));
                                      state(() {
                                        loading = false;
                                      });

                                      setState(() {});
                                      Navigator.pop(context, images);
                                    });
                                  } else {
                                    controller!.takePicture().then((value) {
                                      images.add(File(value.path));
                                      state(() {
                                        loading = false;
                                      });
                                      setState(() {});
                                    });
                                  }
                                }
                              },
                              child:
                                  SvgPicture.asset(IconConstants.photo_button));
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    IconConstants.arrowLeft,
                    // ignore: deprecated_member_use
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      );
    }
  }
}
