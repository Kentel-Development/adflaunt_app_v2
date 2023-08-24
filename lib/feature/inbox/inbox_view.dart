import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/chat/chat_view.dart';
import 'package:adflaunt/generated/l10n.dart';
import 'package:adflaunt/product/models/chat/inbox.dart';
import 'package:adflaunt/product/services/chat.dart';
import 'package:adflaunt/product/widgets/headers/main_header.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  final socket = IO.io(StringConstants.baseUrl,
      IO.OptionBuilder().setTransports(['websocket']).enableForceNew().build());
  final currentUser = Hive.box<ProfileAdapter>('user').get('userData')!;
  @override
  void initState() {
    socket.onConnect((data) {
      print("connected");
    });
    socket.on("receive", (data) {
      print(data["sender"].toString());
      if (currentUser.id == data["receiver"] ||
          currentUser.id == data["sender"]) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Header(hasBackBtn: false, title: S.of(context).inbox),
        ),
      ),
      body: FutureBuilder(
        future: ChatServices.getInbox(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                height: 2,
                color: ColorConstants.backgroundColor,
              ),
              itemCount: snapshot.data!.chatOutput.length,
              itemBuilder: (context, index) {
                final date = DateTime.fromMillisecondsSinceEpoch(
                  (snapshot.data!.chatOutput[index].lastMessageTime * 1000)
                      .toInt(),
                );
                LastMessageClass? lastMessage =
                    snapshot.data!.chatOutput[index].lastMessage.toString() ==
                            ""
                        ? null
                        : LastMessageClass.fromJson(snapshot
                            .data!
                            .chatOutput[index]
                            .lastMessage as Map<String, dynamic>);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<dynamic>(
                      builder: (context) {
                        return ChatView(
                          chatId: snapshot.data!.chatOutput[index].chatId,
                        );
                      },
                    )).then((value) => setState(() {}));
                  },
                  child: Container(
                    height: 92,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                    child: Row(
                      children: [
                        snapshot.data!.chatOutput[index].them.profileImage ==
                                null
                            ? CircleAvatar(
                                radius: 25,
                                child: Icon(Icons.person, color: Colors.white),
                                backgroundColor: ColorConstants.grey200,
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundImage: CachedNetworkImageProvider(
                                    StringConstants.baseStorageUrl +
                                        snapshot.data!.chatOutput[index].them
                                            .profileImage
                                            .toString()),
                              ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        snapshot.data!.chatOutput[index].them
                                            .fullName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text(
                                      date.isSameDay(DateTime.now()) == true
                                          ? DateFormat().add_Hm().format(date)
                                          : DateFormat()
                                              .add_yMMMd()
                                              .format(date),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  lastMessage == null
                                      ? ""
                                      : lastMessage.bookingData == null
                                          ? lastMessage.image == ""
                                              ? lastMessage.content
                                              : S.of(context).photo
                                          : "${lastMessage.bookingData!.data!.customer != currentUser.id ? "You have a new booking for your ${lastMessage.bookingData!.listingData!.title!} listing." : "You made a booking for ${lastMessage.bookingData!.listingData!.title!} listing."}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: LoadingWidget(),
            );
          }
        },
      ),
    );
  }
}
