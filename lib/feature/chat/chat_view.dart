import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/chat/mixin/chat_mixin.dart';
import 'package:adflaunt/product/models/chat/inbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatView extends StatefulWidget {
  const ChatView({required this.chatId, required this.user, super.key});
  final String chatId;
  final Them user;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with ChatMixin {
  @override
  Widget build(BuildContext context) {
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
                      widget.user.profileImage == null
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
                                      widget.user.profileImage.toString()),
                            ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.user.fullName.toString(),
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
              attachmentButtonIcon: Icon(Icons.photo, color: Colors.white),
            ),
            onEndReached: handleEndReached,
            isAttachmentUploading: loading,
            onAttachmentPressed: handleImageSelection,
            messages: messages,
            onSendPressed: handleSendPressed,
            user: user));
  }
}
