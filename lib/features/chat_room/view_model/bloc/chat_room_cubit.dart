import 'package:_qurinom_chat_app/data/socket_client.dart';
import 'package:_qurinom_chat_app/features/auth/repo/auth_repo.dart';
import 'package:_qurinom_chat_app/core/repo/chat_repo.dart';
import 'package:_qurinom_chat_app/features/chat_room/model/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  final ChatRepository repo;
  final AuthRepository auth;
  final SocketService socket;

  String? _userId;
  late final String chatId;

  ChatRoomCubit({
    required this.repo,
    required this.auth,
    required this.socket,
    required this.chatId,
  }) : super(ChatRoomLoading());

  Future<void> init() async {
    try {
      _userId = await auth.userId();
      final list = await repo.messages(chatId);
      list.sort(
        (a, b) =>
            (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)),
      );
      emit(ChatRoomLoaded(messages: list, sending: false));

      socket.connect(auth: {'token': await auth.token()});
      socket.onConnected(() => socket.joinRoom(chatId));
      socket.onMessage((data) {
        if (data['chatId']?.toString() == chatId) {
          final msg = MessageModel.fromMap(data);
          final cur = (state as ChatRoomLoaded).messages;
          emit((state as ChatRoomLoaded).copyWith(messages: [...cur, msg]));
        }
      });
    } catch (e) {
      emit(ChatRoomError(e.toString()));
    }
  }

  Future<void> send(String text) async {
    if (_userId == null) return;
    final optimistic = MessageModel(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      chatId: chatId,
      senderId: _userId!,
      content: text,
      messageType: 'text',
      createdAt: DateTime.now(),
    );
    final cur =
        state is ChatRoomLoaded
            ? (state as ChatRoomLoaded).messages
            : <MessageModel>[];
    emit(ChatRoomLoaded(messages: [...cur, optimistic], sending: true));

    final body = {
      'chatId': chatId,
      'senderId': _userId,
      'content': text,
      'messageType': 'text',
      'fileUrl': '',
    };

    try {
      socket.sendViaSocket(body);
      final saved = await repo.send(
        chatId: chatId,
        senderId: _userId!,
        content: text,
      );
      final replaced = [...cur, saved];
      emit(ChatRoomLoaded(messages: replaced, sending: false));
    } catch (e) {
      emit(ChatRoomLoaded(messages: cur, sending: false, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}
