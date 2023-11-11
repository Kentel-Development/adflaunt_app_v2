import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryView extends StatefulWidget {
  final List<String> images;
  final int currentIndex;

  const PhotoGalleryView({
    Key? key,
    required this.images,
    required this.currentIndex,
  }) : super(key: key);

  @override
  PhotoGalleryViewState createState() => PhotoGalleryViewState();
}

class PhotoGalleryViewState extends State<PhotoGalleryView> {
  PageController? _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(alignment: Alignment.topLeft, children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                  widget.images[index].contains("static/")
                      ? "${StringConstants.baseUrl}/${widget.images[index]}"
                      : "${StringConstants.baseStorageUrl}${widget.images[index]}",
                ),
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.images[index]),
              );
            },
            itemCount: widget.images.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
