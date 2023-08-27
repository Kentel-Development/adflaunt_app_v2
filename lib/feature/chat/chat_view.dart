import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/chat/mixin/chat_mixin.dart';
import 'package:adflaunt/product/widgets/loading_widget.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatView extends StatefulWidget {
  const ChatView({required this.chatId, super.key});
  final String chatId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with ChatMixin, WidgetsBindingObserver {
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    setState(() {
      appLifecycleState = state;
    });
    print('state: $state');
    if (state == AppLifecycleState.resumed) {
      setState(() {
        messages = [];
      });
      socket.connect();
    } else if (state == AppLifecycleState.paused) {
      socket.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (themUser == null) {
      return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Center(
          child: LoadingWidget(),
        ),
      );
    }
    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(alignment: Alignment.topLeft, child: BackButton()),
                  Column(
                    children: [
                      themUser!.profileImage == null ||
                              themUser!.profileImage == ''
                          ? CircleAvatar(
                              radius: 26,
                              backgroundColor: ColorConstants.grey200,
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 26),
                            )
                          : CircleAvatar(
                              radius: 26,
                              backgroundImage: CachedNetworkImageProvider(
                                  StringConstants.baseStorageUrl +
                                      themUser!.profileImage.toString()),
                            ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        themUser!.fullName.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 48,
                  )
                ],
              ),
            ),
          ),
        ),
        body: Chat(
            theme: DefaultChatTheme(
              backgroundColor: ColorConstants.backgroundColor,
              primaryColor: Colors.black,
              secondaryColor: ColorConstants.grey2000,
              attachmentButtonIcon: Icon(
                Icons.photo,
                color: Colors.white,
              ),
            ),
            onMessageDoubleTap: handleMessageTap,
            onEndReached: handleEndReached,
            isAttachmentUploading: loading,
            onAttachmentPressed: handleImageSelection,
            messages: messages,
            onSendPressed: handleSendPressed,
            user: user));
  }
}
