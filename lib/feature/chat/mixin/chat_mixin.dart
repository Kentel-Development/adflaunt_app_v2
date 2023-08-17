import 'dart:convert';
import 'dart:developer';
import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/feature/chat/chat_view.dart';
import 'package:adflaunt/product/models/chat/chat.dart';
import 'package:adflaunt/product/services/chat.dart';
import 'package:adflaunt/product/services/upload.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

mixin ChatMixin on State<ChatView> {
  IO.Socket socket = IO.io(StringConstants.baseUrl,
      IO.OptionBuilder().setTransports(['websocket']).enableForceNew().build());
  ProfileAdapter currentUser =
      Hive.box<ProfileAdapter>('user').get('userData')!;
  String sid = "";
  //chat variables
  List<types.Message> messages = [];
  late types.User user;
  late types.User otherUser;
  bool loading = false;
  int _page = 1;
  @override
  void initState() {
    log("initState");
    user = types.User(
      id: currentUser.id.toString(),
      firstName: currentUser.fullName.toString(),
      imageUrl: currentUser.profileImage == null
          ? null
          : StringConstants.baseStorageUrl +
              currentUser.profileImage.toString(),
    );
    otherUser = types.User(
      id: widget.user.id,
      firstName: widget.user.fullName.toString(),
      imageUrl: widget.user.profileImage == null
          ? null
          : StringConstants.baseStorageUrl +
              widget.user.profileImage.toString(),
    );
    socket.onConnect((data) {
      log("onConnect");
      log(currentUser.email.toString());
      log(currentUser.password.toString());
      log(widget.chatId.toString());
      socket.emitWithAck('join', {
        "email": currentUser.email.toString(),
        "password": currentUser.password.toString(),
        "ChatID": widget.chatId.toString(),
      }, ack: (dynamic data) async {
        log("ack");
        log(jsonEncode(data));
        Chat chat = Chat.fromJson(data as Map<String, dynamic>);
        chat.chat.messages.forEach((element) async {
          if (element.content != "") {
            messages.add(types.TextMessage(
                author: element.sender.toString() == currentUser.id.toString()
                    ? user
                    : otherUser,
                id: element.id.toString(),
                text: element.content.toString(),
                createdAt: (element.at * 1000).toInt()));
          } else {
            messages.add(types.ImageMessage(
              author: user,
              createdAt: (element.at * 1000).toInt(),
              id: element.id,
              name: element.id,
              size: 1,
              uri: StringConstants.baseStorageUrl + element.image,
            ));
          }
        });

        messages.sort((b, a) => a.createdAt!.compareTo(b.createdAt!));
        setState(() {
          messages = messages;
          sid = data["SID"].toString();
        });
      });
    });
    socket.on('receive', (data) {
      final json = (data as Map<String, dynamic>);
      if (json["chatID"].toString() == widget.chatId) {
        if (json["content"] != "") {
          _addMessage((types.TextMessage(
              author: json["sender"].toString() == currentUser.id.toString()
                  ? user
                  : otherUser,
              id: json["_id"].toString(),
              text: json["content"].toString(),
              createdAt: ((json["at"] as double) * 1000).toInt())));
        } else {
          final image = CachedNetworkImageProvider(
              StringConstants.baseStorageUrl + json["image"].toString());
          ImageInfo? info;
          image
              .resolve(const ImageConfiguration())
              .addListener(ImageStreamListener((imnfo, call) {
            info = imnfo;
          }));
          final message = types.ImageMessage(
            author: user,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: json["_id"].toString(),
            name: "",
            size: info!.image.height.toDouble() * info!.image.width.toDouble(),
            height: info!.image.height.toDouble(),
            width: info!.image.width.toDouble(),
            uri: StringConstants.baseStorageUrl + json["image"].toString(),
          );
          _addMessage(message);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> handleEndReached() async {
    final newMessages = await ChatServices.pagination(widget.chatId, _page);
    final _messages = newMessages.map((e) {
      if (e.content != "") {
        return types.TextMessage(
            author: e.sender == currentUser.id.toString() ? user : otherUser,
            id: e.id,
            text: e.content,
            createdAt: (e.at * 1000).toInt());
      } else {
        return types.ImageMessage(
          author: user,
          createdAt: (e.at * 1000).toInt(),
          id: e.id,
          name: e.id,
          size: 1,
          uri: StringConstants.baseStorageUrl + e.image,
        );
      }
    });
    setState(() {
      messages = [...messages, ..._messages];
      _page++;
    });
  }

  void handleSendPressed(types.PartialText message) {
    log("handleSendPressed");
    log(message.text);
    log(sid);
    socket.emitWithAck(
        'send_msg',
        {
          "SID": sid,
          "content": message.text,
          "image": "",
        },
        ack: (data) {});
  }

  void handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (result != null) {
      setState(() {
        loading = true;
      });
      final uri = await UploadService.uploadImage(result.path);
      loading = false;

      socket.emitWithAck(
          'send_msg',
          {
            "SID": sid,
            "content": "",
            "image": uri,
          },
          ack: (data) {});
    }
  }

  void _addMessage(types.Message message) {
    if (mounted) {
      setState(() {
        messages.insert(0, message);
      });
    }
  }
}
