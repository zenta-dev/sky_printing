import 'package:sky_printing/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient with MainBoxMixin, FirebaseCrashLogger {
  final String _baseUrl = const String.fromEnvironment('SERVER_URL');
  final String _socketPath = const String.fromEnvironment('SOCKET_PATH');

  String? _auth;
  bool _isUnitTest = false;
  Socket? _socket;

  SocketClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    try {
      _auth = getData(MainBoxKeys.token);
    } catch (_) {}

    if (_auth != null) {
      _socket = _createSocket();
      connect();
    }
    if (!_isUnitTest) _socket!.connect();
  }

  Socket _createSocket() {
    log.i('SocketClient: $_baseUrl$_socketPath');
    log.i("TOKEN: $_auth");
    return io(
      _baseUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .setPath(_socketPath)
          .setAuth({'token': _auth})
          .build(),
    );
  }

  void disconnect() {
    _socket!.disconnect();
  }

  void connect() {
    _socket!.connect();
  }

  void join(String room) {
    _socket!.emit('join', room);
  }

  void leave(String room) {
    _socket!.emit('leave', room);
  }

  void message(dynamic Function(dynamic) handler) {
    _socket!.on('message', handler);
  }

  void send(String receiver, String sender, String roomId,
      Map<String, dynamic> content) {
    _socket!.emit('message', {
      'receiver': receiver,
      'sender': sender,
      'roomId': roomId,
      'content': content,
    });
  }
}