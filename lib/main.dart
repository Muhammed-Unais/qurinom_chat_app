import 'package:_qurinom_chat_app/core/core/storage/secure_storage.dart';
import 'package:_qurinom_chat_app/features/auth/repo/auth_repo.dart';
import 'package:_qurinom_chat_app/features/auth/view/login_screen.dart';
import 'package:_qurinom_chat_app/features/auth/view_model/bloc/auth_cubit.dart';
import 'package:_qurinom_chat_app/features/chat_list/repo/chat_repo.dart';
import 'package:_qurinom_chat_app/features/chat_list/view/chat_list_screen.dart';
import 'package:_qurinom_chat_app/features/chat_list/view_model/bloc/chat_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SecureStore();
    final authRepo = AuthRepository(store);
    final chatRepo = ChatRepository(store);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider.value(value: chatRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(authRepo)),
          BlocProvider(create: (_) => ChatListCubit(chatRepo, authRepo)),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routes: {
            '/': (_) => const LoginScreen(),
            '/chats': (ctx) => const ChatListScreen(),
          },
        ),
      ),
    );
  }
}
