import 'dart:developer';

import 'package:_qurinom_chat_app/data/app_client.dart';
import 'package:_qurinom_chat_app/features/chat_list/model/chat_list_model.dart';
import 'package:_qurinom_chat_app/features/chat_room/model/message_model.dart';

class ChatRemote {
  final ApiClient _client;
  ChatRemote(this._client);

  Future<List<ChatModel>> getUserChats(String userId) async {
    final res = await _client.dio.get('/chats/user-chats/$userId');
    final data = res.data as List;

    log(data.toString());

    return data.map((e) => ChatModel.fromMap(e)).toList();
  }

  Future<List<MessageModel>> getMessages(String chatId) async {
    final res = await _client.dio.get(
      '/messages/get-messagesformobile/$chatId',
    );

    log(res.toString());
    final data = res.data as List;
    return data.map((e) => MessageModel.fromMap(e)).toList();
  }

  Future<MessageModel> sendMessage({
    required String chatId,
    required String senderId,
    required String content,
    String messageType = 'text',
    String fileUrl = '',
  }) async {
    final res = await _client.dio.post(
      '/messages/sendMessage',
      data: {
        'chatId': chatId,
        'senderId': senderId,
        'content': content,
        'messageType': messageType,
        'fileUrl': fileUrl,
      },
    );

    log("${res.data} message sender response");
    return MessageModel.fromMap(res.data as Map<String, dynamic>);
  }
}
