import 'dart:convert';

import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/extensions/string_extensions.dart';
import 'package:adflaunt/product/services/balance.dart';
import 'package:adflaunt/product/widgets/common_btn.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../../generated/l10n.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: true, title: S.of(context).balance),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                S.of(context).withdrawFromYourBalance,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins"),
              ),
            ),
            SizedBox(
              height: 65,
            ),
            FutureBuilder(
                future: BalanceAPI.getBalance(),
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border:
                            Border.all(color: ColorConstants.grey300, width: 1),
                      ),
                      child: !(snapshot.hasData)
                          ? Center(
                              child: LoadingWidget(),
                            )
                          : Column(children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Your Balance:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      Text(
                                        ((jsonDecode(snapshot.data!))["balance"]
                                                .toString())
                                            .toPriceFormat,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0,
                                    top: 32.0,
                                    left: 8.0,
                                    right: 8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: CommonBtn(
                                    backgroundColor: Colors.black,
                                    text: S.of(context).withdraw,
                                    onPressed: () async {
                                      if (double.parse(
                                              (jsonDecode(snapshot.data!)
                                                      as Map<String,
                                                          dynamic>)["balance"]
                                                  .toString()) >
                                          0) {
                                        final Email email = Email(
                                          subject: 'Withdrawal Request',
                                          recipients: ['flauntad@gmail.com'],
                                          isHTML: false,
                                        );
                                        try {
                                          await FlutterEmailSender.send(email);
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "You have no email app installed. Please send your balance withdrawal request to flauntad@gmail.com"),
                                            duration: Duration(seconds: 2),
                                          ));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .youDontHaveEnoughBalanceToWithdraw),
                                          duration: Duration(seconds: 2),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              )
                            ]),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
