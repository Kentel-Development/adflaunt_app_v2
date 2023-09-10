import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:adflaunt/product/services/reviews.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:adflaunt/product/widgets/review_widget.dart';
import 'package:flutter/material.dart';

import '../../product/widgets/headers/main_header.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({required this.listingId, super.key});
  final String listingId;
  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  final ScrollController _scrollController = ScrollController();

  List<Review> reviews = <Review>[];
  int page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    ReviewService.getReviews(widget.listingId, page).then((value) {
      value['reviews'].forEach((dynamic review) {
        reviews.add(Review.fromJson(review as Map<String, dynamic>));
      });
      setState(() {});
    });
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!_isLoading) {
        setState(() {
          page++;
          _isLoading = true;
        });
        ReviewService.getReviews(widget.listingId, page).then((value) async {
          value['reviews'].forEach((dynamic review) {
            reviews.add(Review.fromJson(review as Map<String, dynamic>));
          });
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: S.of(context).reviews),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: reviews.isEmpty
          ? Center(
              child: LoadingWidget(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ReviewWidget(
                      profileImage: reviews[index].customer.profileImage,
                      fullName: reviews[index].customer.fullName,
                      review: reviews[index].review,
                      star: reviews[index].star,
                      at: reviews[index].at);
                },
              )),
    );
  }
}
