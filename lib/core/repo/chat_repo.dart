import 'package:_qurinom_chat_app/core/storage/secure_storage.dart';
import 'package:_qurinom_chat_app/data/app_client.dart';
import 'package:_qurinom_chat_app/data/resources/chat_remote.dart';
import 'package:_qurinom_chat_app/features/chat_list/model/chat_list_model.dart';
import 'package:_qurinom_chat_app/features/chat_room/model/message_model.dart';

class ChatRepository {
  final SecureStore _store;
  late final ChatRemote _remote;

  ChatRepository(this._store) {
    _remote = ChatRemote(ApiClient());
  }

  Future<List<ChatModel>> listUserChats(String userId) =>
      _remote.getUserChats(userId);

  Future<List<MessageModel>> messages(String chatId) =>
      _remote.getMessages(chatId);

  Future<MessageModel> send({
    required String chatId,
    required String senderId,
    required String content,
    String type = 'text',
    String fileUrl = '',
  }) => _remote.sendMessage(
    chatId: chatId,
    senderId: senderId,
    content: content,
    messageType: type,
    fileUrl: fileUrl,
  );
}
