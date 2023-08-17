import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/color_constants.dart';
import '../../../generated/l10n.dart';
import 'cubit/post_ad_cubit.dart';

class SelectLocationTab extends StatefulWidget {
  const SelectLocationTab({super.key});

  @override
  State<SelectLocationTab> createState() => _SelectLocationTabState();
}

class _SelectLocationTabState extends State<SelectLocationTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Text(S.of(context).selectLocation,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(S.of(context).youCanMoveTheMapToSetTheLocationOf,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
        ValueListenableBuilder(
            valueListenable:
                ValueNotifier(context.watch<PostAdCubit>().currentLocation),
            builder: (context, value, child) {
              return context.watch<PostAdCubit>().currentLocation == null
                  ? const Center(child: LoadingWidget())
                  : Expanded(
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapToolbarEnabled: false,
                            myLocationEnabled: false,
                            myLocationButtonEnabled: false,
                            // ignore: prefer_collection_literals
                            gestureRecognizers: Set()
                              ..add(Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer()))
                              ..add(Factory<ScaleGestureRecognizer>(
                                  () => ScaleGestureRecognizer()))
                              ..add(Factory<TapGestureRecognizer>(
                                  () => TapGestureRecognizer())),
                            onMapCreated: (controller) {
                              context.read<PostAdCubit>().mapController =
                                  controller;

                              context
                                  .read<PostAdCubit>()
                                  .mapController!
                                  .animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                            context
                                                .read<PostAdCubit>()
                                                .currentLocation!
                                                .latitude,
                                            context
                                                .read<PostAdCubit>()
                                                .currentLocation!
                                                .longitude),
                                        zoom: 15,
                                      ),
                                    ),
                                  );
                            },
                            onCameraMove: (position) {
                              if (context.read<PostAdCubit>().searchMarker !=
                                  null) {
                                context.read<PostAdCubit>().searchMarker =
                                    context
                                        .read<PostAdCubit>()
                                        .searchMarker!
                                        .copyWith(
                                          positionParam: position.target,
                                        );
                                context.read<PostAdCubit>().currentLocation =
                                    position.target;
                                setState(() {});
                              }
                            },
                            initialCameraPosition: CameraPosition(
                              target:
                                  context.watch<PostAdCubit>().currentLocation!,
                              zoom: 15,
                            ),
                            markers: context.read<PostAdCubit>().searchMarker !=
                                    null
                                // ignore: prefer_collection_literals
                                ? Set.of(
                                    [context.read<PostAdCubit>().searchMarker!])
                                : {},
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                                controller: context
                                    .watch<PostAdCubit>()
                                    .searchController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.location_pin,
                                    color: ColorConstants.colorPrimary,
                                  ),
                                  hintText: S.of(context).enterYourAddress,
                                  hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConstants.colorPrimary,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide: const BorderSide(
                                      width: 4,
                                      color: ColorConstants.colorPrimary,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                onSubmitted:
                                    context.read<PostAdCubit>().searchAddress),
                          ),
                        ],
                      ),
                    );
            }),
      ],
    );
  }
}
