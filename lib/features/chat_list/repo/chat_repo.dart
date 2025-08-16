import 'package:_qurinom_chat_app/core/core/storage/secure_storage.dart';
import 'package:_qurinom_chat_app/data/app_client.dart';
import 'package:_qurinom_chat_app/data/resources/chat_remote.dart';
import 'package:_qurinom_chat_app/features/chat_list/model/chat_list_model.dart';

class ChatRepository {
  final SecureStore _store;
  late final ChatRemote _remote;

  ChatRepository(this._store) {
    _remote = ChatRemote(ApiClient());
  }

  Future<List<ChatModel>> listUserChats(String userId) =>
      _remote.getUserChats(userId);
}
