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
    socket.connect();
    socket.onConnect((data) {
      print("connected");
    });
    socket.on("receive", (data) {
      print("sender:" + data["sender"].toString());
      print("receiver:" + data["receiver"].toString());
      if (currentUser.id == data["receiver"] ||
          currentUser.id == data["sender"]) {
        print("received");
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
            if (snapshot.data!.chatOutput.length == 0) {
              return Center(
                child: Text(
                  "No chats",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              );
            } else
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
                      )).then((value) async {
                        setState(() {
                          snapshot.data!.chatOutput[index].unreadMessages = 0;
                        });
                        socket.connect();
                      });
                    },
                    child: Container(
                      height: 92,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                      child: Row(
                        children: [
                          snapshot.data!.chatOutput[index].them.profileImage ==
                                  null
                              ? CircleAvatar(
                                  radius: 25,
                                  child:
                                      Icon(Icons.person, color: Colors.white),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          snapshot.data!.chatOutput[index].them
                                              .fullName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Flexible(
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
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      date.isSameDay(DateTime.now()) == true
                                          ? DateFormat(DateFormat.HOUR_MINUTE)
                                              .format(date)
                                          : DateFormat()
                                              .add_yMMMd()
                                              .format(date),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    snapshot.data!.chatOutput[index]
                                                .unreadMessages ==
                                            0
                                        ? Container()
                                        : Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  221, 27, 73, 1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                snapshot.data!.chatOutput[index]
                                                            .unreadMessages! >
                                                        9
                                                    ? "9+"
                                                    : snapshot
                                                        .data!
                                                        .chatOutput[index]
                                                        .unreadMessages
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
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
