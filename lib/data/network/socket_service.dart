import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'endpoints.dart';

class SocketService {
  IO.Socket socket;

  createMessageSocketConnection() {
    socket = IO.io("${Endpoints.host}/message", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    this.socket.on("connect", (_) => print('Message Connected'));
    this.socket.on("disconnect", (_) => print('Message Disconnected'));
  }

  connectWithToken(IO.Socket socket, String token) {
    socket.opts['query'] = Map();
    socket.opts['query']['token'] = token;
    socket.connect();
  }
}
