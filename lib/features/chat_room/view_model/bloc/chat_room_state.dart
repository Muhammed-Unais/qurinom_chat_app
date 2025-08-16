part of 'chat_room_cubit.dart';

abstract class ChatRoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomError extends ChatRoomState {
  final String message;
  ChatRoomError(this.message);
  @override
  List<Object?> get props => [message];
}

class ChatRoomLoaded extends ChatRoomState {
  final List<MessageModel> messages;
  final bool sending;
  final String? error;
  ChatRoomLoaded({required this.messages, required this.sending, this.error});

  ChatRoomLoaded copyWith({
    List<MessageModel>? messages,
    bool? sending,
    String? error,
  }) => ChatRoomLoaded(
    messages: messages ?? this.messages,
    sending: sending ?? this.sending,
    error: error ?? this.error,
  );

  @override
  List<Object?> get props => [messages, sending, error];
}
