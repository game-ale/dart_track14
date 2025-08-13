import 'package:socket_io_client/socket_io_client.dart' as IO;

/// A reusable, production-ready socket.io service
class SocketService {
  late IO.Socket _socket;
  bool _isConnected = false;

  final String url;
  final Map<String, dynamic>? headers;
  final Duration reconnectDelay;
  final int maxReconnectAttempts;

  SocketService({
    required this.url,
    this.headers,
    this.reconnectDelay = const Duration(seconds: 5),
    this.maxReconnectAttempts = 5,
  });

  /// Initialize the socket instance (does not connect yet)
  void init() {
    _socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Avoids polling fallback in Flutter
          .setExtraHeaders(headers ?? {})
          .disableAutoConnect() // We'll control connection
          .enableForceNew() // Avoid stale connections
          .build(),
    );

    _registerCoreListeners();
  }

  /// Connect to server
  void connect() {
    if (_isConnected) return;
    print('[Socket] Connecting...');
    _socket.connect();
  }

  /// Disconnect from server
  void disconnect() {
    print('[Socket] Disconnecting...');
    _socket.disconnect();
    _isConnected = false;
  }

  /// Dispose completely
  void dispose() {
    print('[Socket] Disposing socket...');
    _socket.dispose();
    _isConnected = false;
  }

  /// Send event to server
  void emit(String event, dynamic data, {Function? ack}) {
    if (!_isConnected) {
      print('[Socket] Emit failed: Not connected.');
      return;
    }
    ack != null
        ? _socket.emitWithAck(event, data, ack: ack)
        : _socket.emit(event, data);
  }

  /// Listen for server event
  void on(String event, Function(dynamic) handler) {
    _socket.on(event, handler);
  }

  /// Stop listening for server event
  void off(String event) {
    _socket.off(event);
  }

  /// Register core connection & error listeners
  void _registerCoreListeners() {
    _socket.onConnect((_) {
      _isConnected = true;
      print('[Socket] Connected ✅');
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      print('[Socket] Disconnected ❌');
      _tryReconnect();
    });

    _socket.onError((err) {
      print('[Socket] Error: $err');
    });

    _socket.onConnectError((err) {
      print('[Socket] Connection error: $err');
      _tryReconnect();
    });

    _socket.onReconnect((attempt) {
      print('[Socket] Reconnected after $attempt attempts 🔄');
    });

    _socket.onReconnectAttempt((attempt) {
      print('[Socket] Reconnection attempt $attempt...');
    });
  }

  /// Attempt reconnection with delay & limit
  void _tryReconnect() {
    int attempts = 0;
    Future.doWhile(() async {
      if (_isConnected || attempts >= maxReconnectAttempts) return false;
      attempts++;
      print('[Socket] Reconnect attempt $attempts...');
      await Future.delayed(reconnectDelay);
      connect();
      return !_isConnected;
    });
  }
}
