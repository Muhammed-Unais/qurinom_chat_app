import 'dart:developer';

import 'package:_qurinom_chat_app/data/app_client.dart';
import 'package:_qurinom_chat_app/features/chat_list/model/chat_list_model.dart';

class ChatRemote {
  final ApiClient _client;
  ChatRemote(this._client);

  Future<List<ChatModel>> getUserChats(String userId) async {
    final res = await _client.dio.get('/chats/user-chats/$userId');
    final data = res.data as List;

    log(data.toString());

    return data.map((e) => ChatModel.fromMap(e)).toList();
  }
}
