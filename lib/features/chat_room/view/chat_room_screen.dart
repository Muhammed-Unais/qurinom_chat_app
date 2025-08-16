import 'package:_qurinom_chat_app/features/chat_room/view_model/bloc/chat_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  final String senderName;
  final String userId;
  const ChatRoomScreen({
    super.key,
    required this.userId,
    required this.senderName,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ctrl = TextEditingController();
  final scrollController = ScrollController();
  int length = 0;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final chatRoomCubit = context.read<ChatRoomCubit>();

    await chatRoomCubit.init();

    if (chatRoomCubit.state is ChatRoomLoaded) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.senderName)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatRoomCubit, ChatRoomState>(
              builder: (context, state) {
                if (state is ChatRoomLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChatRoomError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                final s = state as ChatRoomLoaded;

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: s.messages.length,
                  itemBuilder: (_, i) {
                    final m = s.messages[i];
                    final isMe = m.senderId == widget.userId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(m.content),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      suffixIcon: GestureDetector(),
                      suffixIconConstraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.1,
                        maxHeight: MediaQuery.of(context).size.width * 0.06,
                        minHeight: MediaQuery.of(context).size.width * 0.06,
                        minWidth: MediaQuery.of(context).size.width * 0.1,
                      ),
                      hintText: 'Send message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = ctrl.text.trim();
                    if (text.isEmpty) return;
                    await context.read<ChatRoomCubit>().send(text);

                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      scrollController.jumpTo(
                        scrollController.position.maxScrollExtent,
                      );
                    });
                    ctrl.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
