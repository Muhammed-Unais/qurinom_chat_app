part of 'chat_list_cubit.dart';

abstract class ChatListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListSuccess extends ChatListState {
  final List<ChatModel> items;
  ChatListSuccess(this.items);
  @override
  List<Object?> get props => [items];
}

class ChatListFailure extends ChatListState {
  final String message;
  ChatListFailure(this.message);
  @override
  List<Object?> get props => [message];
}
