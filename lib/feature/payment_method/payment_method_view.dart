import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/icon_constants.dart';
import 'package:adflaunt/product/services/payment_service.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: S.of(context).paymentMethod),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                S
                    .of(context)
                    .addSomePaymentMethodsToMakeYourBookingProcessFaster,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            FutureBuilder(
                future: PaymentService().listPaymentMethods(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    log(snapshot.data.toString());
                    final json =
                        jsonDecode(snapshot.data!) as Map<String, dynamic>;
                    if (json["SCC"] != false) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: (json["data"].length as int) + 1,
                            itemBuilder: (context, index) {
                              if ((json["data"].length as int) == index) {
                                return SizedBox(
                                  height: 45,
                                  child: GestureDetector(
                                    onTap: () async {
                                      // ignore: inference_failure_on_function_invocation
                                      showDialog(
                                        context: context,
                                        builder: (context3) {
                                          return StatefulBuilder(
                                              builder: (context2, state) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              actionsPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              title: const Text(
                                                  "Add Payment Method"),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CardField(
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2)),
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
                                                          Navigator.pop(
                                                              context);
                                                          try {
                                                            // ignore: inference_failure_on_function_invocation
                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BackdropFilter(
                                                                    filter: ImageFilter.blur(
                                                                        sigmaX:
                                                                            10,
                                                                        sigmaY:
                                                                            10),
                                                                    child:
                                                                        const AlertDialog(
                                                                      title: Text(
                                                                          "Adding Card..."),
                                                                      content:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          CircularProgressIndicator(
                                                                            color:
                                                                                Colors.black,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });

                                                            final clientSecret =
                                                                await PaymentService()
                                                                    .createSetupIntent();
                                                            final dataReturned =
                                                                jsonDecode(
                                                                    clientSecret
                                                                        .toString());
                                                            log(clientSecret
                                                                .toString());

                                                            // 3. Confirm setup intent

                                                            final setupIntentResult =
                                                                await Stripe
                                                                    .instance
                                                                    .confirmSetupIntent(
                                                              paymentIntentClientSecret:
                                                                  dataReturned[
                                                                          "paymentIntent"]
                                                                      .toString(),
                                                              params:
                                                                  const PaymentMethodParams
                                                                      .card(
                                                                paymentMethodData:
                                                                    PaymentMethodData(),
                                                              ),
                                                            );
                                                            final attachData =
                                                                await PaymentService().attach(
                                                                    setupIntentResult
                                                                        .paymentMethodId);
                                                            log(attachData
                                                                .toString());
                                                            log('Setup Intent created $setupIntentResult');

                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                            // ignore: use_build_context_synchronously
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromRGBO(
                                                                      241,
                                                                      95,
                                                                      95,
                                                                      1),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              content: const Text(
                                                                  "Card Added Successfully"),
                                                            ));
                                                          } catch (e) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromRGBO(
                                                                      241,
                                                                      95,
                                                                      95,
                                                                      1),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              content: Text((e
                                                                      as StripeException)
                                                                  .error
                                                                  .localizedMessage
                                                                  .toString()),
                                                            ));
                                                          }
                                                        },
                                                        text: "Add Card",
                                                        backgroundColor:
                                                            Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorConstants.grey300,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(IconConstants.add),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            S.of(context).addPaymentMethod,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                bool loading = false;
                                return ListTile(
                                  trailing: StatefulBuilder(
                                      builder: (context, state) {
                                    return IconButton(
                                        onPressed: () async {
                                          if (!loading) {
                                            state(() {
                                              loading = true;
                                            });
                                            await PaymentService().detach(
                                                json["data"][index]["id"]
                                                    .toString());
                                            setState(() {});
                                            state(() {
                                              loading = false;
                                            });
                                          }
                                        },
                                        icon: loading
                                            ? CircularProgressIndicator(
                                                color: Colors.black,
                                              )
                                            : Icon(Icons.delete));
                                  }),
                                  title: Text(json["data"][index]["card"]
                                          ["brand"]
                                      .toString()),
                                  subtitle: Text(json["data"][index]["card"]
                                          ["last4"]
                                      .toString()),
                                );
                              }
                            }),
                      );
                    } else {
                      return SizedBox(
                        height: 45,
                        child: GestureDetector(
                          onTap: () async {
                            // ignore: inference_failure_on_function_invocation
                            showDialog(
                              context: context,
                              builder: (context3) {
                                return StatefulBuilder(
                                    builder: (context2, state) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    actionsPadding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4),
                                    title: const Text("Add Payment Method"),
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
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black,
                                                          width: 2)),
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
                                                  // ignore: inference_failure_on_function_invocation
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 10,
                                                                  sigmaY: 10),
                                                          child:
                                                              const AlertDialog(
                                                            title: Text(
                                                                "Adding Card..."),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });

                                                  final clientSecret =
                                                      await PaymentService()
                                                          .createSetupIntent();
                                                  final dataReturned =
                                                      jsonDecode(clientSecret
                                                          .toString());
                                                  log(clientSecret.toString());

                                                  // 3. Confirm setup intent

                                                  final setupIntentResult =
                                                      await Stripe.instance
                                                          .confirmSetupIntent(
                                                    paymentIntentClientSecret:
                                                        dataReturned[
                                                                "paymentIntent"]
                                                            .toString(),
                                                    params:
                                                        const PaymentMethodParams
                                                            .card(
                                                      paymentMethodData:
                                                          PaymentMethodData(),
                                                    ),
                                                  );
                                                  final attachData =
                                                      await PaymentService()
                                                          .attach(setupIntentResult
                                                              .paymentMethodId);
                                                  log(attachData.toString());
                                                  log('Setup Intent created $setupIntentResult');

                                                  // ignore: use_build_context_synchronously
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            241, 95, 95, 1),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    content: const Text(
                                                        "Card Added Successfully"),
                                                  ));
                                                } catch (e) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            241, 95, 95, 1),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    content: Text(
                                                        (e as StripeException)
                                                            .error
                                                            .localizedMessage
                                                            .toString()),
                                                  ));
                                                }
                                              },
                                              text: "Add Card",
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
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.grey300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SvgPicture.asset(IconConstants.add),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  S.of(context).addPaymentMethod,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: LoadingWidget(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
