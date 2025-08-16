import 'package:_qurinom_chat_app/features/auth/repo/auth_repo.dart';
import 'package:_qurinom_chat_app/features/chat_list/model/chat_list_model.dart';
import 'package:_qurinom_chat_app/features/chat_list/repo/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final ChatRepository chats;
  final AuthRepository auth;
  ChatListCubit(this.chats, this.auth) : super(ChatListInitial());

  Future<void> load() async {
    emit(ChatListLoading());
    try {
      final userId = await auth.userId();
      if (userId == null || userId.isEmpty) {
        emit(ChatListFailure('Missing userId. Log in again.'));
        return;
      }
      final list = await chats.listUserChats(userId);
      emit(ChatListSuccess(list));
    } catch (e) {
      emit(ChatListFailure(e.toString()));
    }
  }
}
