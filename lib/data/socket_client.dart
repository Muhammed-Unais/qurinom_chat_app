import 'package:_qurinom_chat_app/core/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef MessageHandler = void Function(Map<String, dynamic> msg);

class SocketService {
  IO.Socket? _socket;
  bool get connected => _socket?.connected ?? false;

  void connect({Map<String, dynamic>? auth}) {
    if (_socket?.connected == true) return;
    _socket = IO.io(
      AppConfig.socketUrl + (AppConfig.socketNamespace),
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setTimeout(8000)
          .setAuth(auth!)
          .build(),
    );
  }

  void onConnected(void Function() cb) => _socket?.onConnect((_) => cb());
  void onDisconnected(void Function(dynamic) cb) => _socket?.onDisconnect(cb);

  void joinRoom(String chatId) {
    _socket?.emit(AppConfig.eventJoinRoom, {'chatId': chatId});
  }

  void onMessage(MessageHandler handler) {
    _socket?.on(AppConfig.eventReceiveMessage, (data) {
      if (data is Map<String, dynamic>) {
        handler(data);
      } else if (data is Map) {
        handler(Map<String, dynamic>.from(data));
      }
    });
  }

  void sendViaSocket(Map<String, dynamic> body) {
    _socket?.emit(AppConfig.eventSendMessage, body);
  }

  void dispose() {
    _socket?.dispose();
    _socket?.close();
    _socket = null;
  }
}
