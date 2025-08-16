import 'package:_qurinom_chat_app/core/storage/secure_storage.dart';
import 'package:_qurinom_chat_app/data/socket_client.dart';
import 'package:_qurinom_chat_app/features/auth/repo/auth_repo.dart';
import 'package:_qurinom_chat_app/features/auth/view/login_screen.dart';
import 'package:_qurinom_chat_app/features/auth/view_model/bloc/auth_cubit.dart';
import 'package:_qurinom_chat_app/core/repo/chat_repo.dart';
import 'package:_qurinom_chat_app/features/chat_list/view/chat_list_screen.dart';
import 'package:_qurinom_chat_app/features/chat_list/view_model/bloc/chat_list_cubit.dart';
import 'package:_qurinom_chat_app/features/chat_room/view/chat_room_screen.dart';
import 'package:_qurinom_chat_app/features/chat_room/view_model/bloc/chat_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = SecureStore();
  final authRepo = AuthRepository(store);
  final token = await authRepo.token();
  final userId = await authRepo.userId();
  runApp(
    MyApp(authRepo: authRepo, secureStore: store, token: token, userId: userId),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.secureStore,
    required this.authRepo,
    this.token,
    this.userId,
  });

  final SecureStore secureStore;
  final AuthRepository authRepo;
  final String? token;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final chatRepo = ChatRepository(secureStore);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider.value(value: chatRepo),
        RepositoryProvider(create: (_) => SocketService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(authRepo)),
          BlocProvider(create: (_) => ChatListCubit(chatRepo, authRepo)),
        ],
        child: MaterialApp(
          title: 'qurinom_chat_app',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routes: {
            '/':
                (_) =>
                    token == null
                        ? const LoginScreen()
                        : const ChatListScreen(),
            '/chats': (ctx) => const ChatListScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/chatRoom') {
              final arg = settings.arguments as (String, BuildContext, String);
              final currentContext = arg.$2;
              final chatId = arg.$1;
              final senderName = arg.$3;
              final repo = RepositoryProvider.of<ChatRepository>(
                currentContext,
              );
              final auth = RepositoryProvider.of<AuthRepository>(
                currentContext,
              );
              final socket = RepositoryProvider.of<SocketService>(
                currentContext,
              );
              return MaterialPageRoute(
                builder:
                    (_) => BlocProvider(
                      create:
                          (_) => ChatRoomCubit(
                            repo: repo,
                            auth: auth,
                            socket: socket,
                            chatId: chatId,
                          ),
                      child: ChatRoomScreen(
                        senderName: senderName,
                        userId: userId!,
                      ),
                    ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
