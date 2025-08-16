import 'dart:developer';

import 'package:_qurinom_chat_app/features/chat_list/view_model/bloc/chat_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: BlocBuilder<ChatListCubit, ChatListState>(
        builder: (context, state) {
          if (state is ChatListInitial) {
            context.read<ChatListCubit>().load();
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatListFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          final items = (state as ChatListSuccess).items;
          if (items.isEmpty) return const Center(child: Text('No chats yet'));
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (c, i) {
              final chat = items[i];

              log(chat.participants.length.toString());
              return ListTile(
                title: Text(
                  chat.isGroupChat
                      ? 'Group Chat'
                      : chat.participants[0].name ?? '',
                ),
                subtitle: Text(chat.lastMessage?.content ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
