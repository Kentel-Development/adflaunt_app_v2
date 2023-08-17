// ignore_for_file: inference_failure_on_function_invocation

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:adflaunt/core/extensions/date_parser_extension.dart';
import 'package:adflaunt/feature/booking/booking_view.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/services/booking.dart';
import 'package:adflaunt/product/services/compress_files.dart';
import 'package:adflaunt/product/services/upload.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../product/models/profile/profile_model.dart';
import '../../../product/services/chat.dart';
import '../../../product/services/payment_service.dart';
import '../../../product/services/user.dart';
import '../../../product/widgets/common_btn.dart';
import '../../chat/chat_view.dart';

import 'package:adflaunt/product/models/chat/inbox.dart' as chat;

mixin BookingMixin on State<BookingView> {
  late int selectedPage;
  late final PageController pageController;
  late List<String> adSpecs = [
    widget.listing.typeOfAdd,
    widget.listing.tags[0],
    widget.listing.tags[1],
    "${widget.listing.height.round()}in X ${widget.listing.width.round()}in = ${widget.listing.sqfeet.round()} sqft",
  ];
  DateRangePickerController datePickerController = DateRangePickerController();
  List<XFile> files = [];
  int? selectedPaymentMethod;
  List<dynamic>? paymentMethods;
  int get bookedDays => datePickerController.selectedRange == null
      ? 0
      : datePickerController.selectedRange!.endDate == null
          ? 1
          : (datePickerController.selectedRange!.endDate!
                  .difference(datePickerController.selectedRange!.startDate!)
                  .inDays +
              1);
  bool loading = false;
  int? printFee;
  List<String> unavailableDates = [];
  @override
  void initState() {
    PaymentService().listPaymentMethods().then((value) {
      final json = jsonDecode(value) as Map<String, dynamic>;
      if (json['SCC'] != false) {
        setState(() {
          paymentMethods = json['data'] as List<dynamic>;
        });
      } else {
        setState(() {
          paymentMethods = [];
        });
      }
    });
    pageController = PageController(initialPage: 0);
    selectedPage = 0;
    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      selectedPage = page;
    });
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      result.files.forEach((element) {
        setState(() {
          files.add(XFile(element.path!));
        });
      });
    }
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        files.add(image);
      });
    }
  }

  void onChatTap() async {
    ProfileModel user = await UserServices.getUser(widget.listing.user);
    String id = await ChatServices.createChat(widget.listing.user);
    try {
      Navigator.push(context, MaterialPageRoute<dynamic>(
        builder: (context) {
          return ChatView(
            chatId: id,
            user: chat.Them(
                id: user.id,
                fullName: user.fullName,
                backPhotoId: "",
                dateOfBirth: user.dateOfBirth == null
                    ? DateTime.now().toString()
                    : DateTime.parse(user.dateOfBirth.toString()).toString(),
                deliveryAddress: "",
                email: user.email,
                idVerified: user.idVerified,
                inbox: [""],
                ipdata: chat.Ipdata.fromJson(user.ipdata.toJson()),
                ipraw: user.ipraw,
                lastTimeLoggedIn: 0,
                profileImage: user.profileImage,
                phoneNumber:
                    user.phoneNumber == null ? "" : user.phoneNumber.toString(),
                photoOfId: "",
                thirdParty: user.thirdParty),
          );
        },
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void addCard() async {
    showDialog(
      context: context,
      builder: (context3) {
        return StatefulBuilder(builder: (context2, state) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            title: Text(S.of(context).addPaymentMethod),
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardField(
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                    ),
                    onCardChanged: (card) {
                      state(() {
                        card = card;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: CommonBtn(
                      onPressed: () async {
                        Navigator.pop(context);
                        try {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: const AlertDialog(
                                    title: Text("Adding Card..."),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });

                          final clientSecret =
                              await PaymentService().createSetupIntent();
                          final dataReturned =
                              jsonDecode(clientSecret.toString());
                          log(clientSecret.toString());

                          // 3. Confirm setup intent

                          final setupIntentResult =
                              await Stripe.instance.confirmSetupIntent(
                            paymentIntentClientSecret:
                                dataReturned["paymentIntent"].toString(),
                            params: const PaymentMethodParams.card(
                              paymentMethodData: PaymentMethodData(),
                            ),
                          );
                          final attachData = await PaymentService()
                              .attach(setupIntentResult.paymentMethodId);
                          log(attachData.toString());
                          log('Setup Intent created $setupIntentResult');

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                const Color.fromRGBO(241, 95, 95, 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Text(S.of(context).cardAddedSuccessfully),
                          ));
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                const Color.fromRGBO(241, 95, 95, 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Text((e as StripeException)
                                .error
                                .localizedMessage
                                .toString()),
                          ));
                        }
                      },
                      text: S.of(context).addCard,
                      backgroundColor: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void confirmAndPay() async {
    bool isBlackouted = false;
    if (unavailableDates.length > 0) {
      for (var element in unavailableDates) {
        if (datePickerController.selectedRange!.startDate!
                .isBefore(element.parseBookingDate()) &&
            (datePickerController.selectedRange!.endDate ?? DateTime.now())
                .isAfter(element.parseBookingDate())) {
          isBlackouted = true;
        }
      }
    }
    if (isBlackouted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromRGBO(241, 95, 95, 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content:
            Text(S.of(context).pleaseSelectADateRangeWithoutUnavailableDates),
      ));
    } else {
      if (bookedDays > 0) {
        setState(() {
          loading = true;
        });
        Map<String, dynamic>? payInt;
        if (selectedPaymentMethod == null) {
          payInt = jsonDecode(await PaymentService().createPaymentIntent(
              widget.listing.id!,
              datePickerController.selectedRange!.startDate!,
              datePickerController.selectedRange!.endDate ??
                  datePickerController.selectedRange!.startDate!,
              null)) as Map<String, dynamic>;
        } else {
          payInt = jsonDecode(await PaymentService().createPaymentIntent(
                  widget.listing.id!,
                  datePickerController.selectedRange!.startDate!,
                  datePickerController.selectedRange!.endDate ??
                      datePickerController.selectedRange!.startDate!,
                  paymentMethods![selectedPaymentMethod!]["id"].toString()))
              as Map<String, dynamic>;
        }

        if (selectedPaymentMethod != null) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AlertDialog(
                  title: Text(
                    S.of(context).paymentProcessing,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(12, 12, 38, 1),
                    ),
                  ),
                  content: SizedBox(
                    height: 100,
                    child: const Center(child: LoadingWidget()),
                  ),
                ),
              );
            },
          );
        }
        try {
          if (selectedPaymentMethod == null) {
            await Stripe.instance.confirmPlatformPayPaymentIntent(
                clientSecret: payInt["paymentIntent"].toString(),
                confirmParams: PlatformPayConfirmParams.applePay(
                    applePay: ApplePayParams(
                        merchantCountryCode: "US",
                        currencyCode: "USD",
                        cartItems: [
                      ApplePayCartSummaryItem.immediate(
                          label: widget.listing.title,
                          amount: ((widget.listing.price * bookedDays) +
                                  printFee!.toDouble())
                              .toString())
                    ])));
          } else {
            await Stripe.instance.confirmPayment(
              paymentIntentClientSecret: payInt["paymentIntent"].toString(),
              data: PaymentMethodParams.cardFromMethodId(
                  paymentMethodData: PaymentMethodDataCardFromMethod(
                      paymentMethodId: payInt["paymentID"].toString())),
            );
          }
          if (selectedPaymentMethod != null) {
            Navigator.pop(context);
          }
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AlertDialog(
                  title: Text(
                    S.of(context).bookingProcessing,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(12, 12, 38, 1),
                    ),
                  ),
                  content: SizedBox(
                    height: 100,
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  ),
                ),
              );
            },
          );
          List<String> filePaths = []
            ..addAll(files.map((e) => e.path.toString()));
          String? url;
          if (filePaths.isNotEmpty) {
            String archivedFileName =
                await ArchiveService.compressFiles(filePaths);
            url = await UploadService.uploadImage(archivedFileName);
          } else {
            url = null;
          }
          await BookingService.makeBooking(
            datePickerController.selectedRange!.startDate!,
            datePickerController.selectedRange!.endDate ??
                datePickerController.selectedRange!.startDate!,
            widget.listing.title,
            widget.listing.id!,
            widget.listing.description,
            url,
            payInt["paymentID"].toString(),
          );
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
              return AlertDialog(
                title: Text(
                  S.of(context).bookingSuccessful,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(12, 12, 38, 1),
                  ),
                ),
              );
            },
          );
          setState(() {
            loading = false;
          });
        } catch (e) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromRGBO(241, 95, 95, 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content:
                Text((e as StripeException).error.localizedMessage.toString()),
          ));
          setState(() {
            loading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromRGBO(241, 95, 95, 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(S.of(context).pleaseSelectAtLeastOneDayToBook),
        ));
      }
    }
  }
}
