abstract class ChatRealtimeDataSource {
  void connect();
  void disconnect();
  void sendMessage(String message);
  void onMessage(void Function(String) callback);
}

class ChatRealtimeDataSourceImpl implements ChatRealtimeDataSource {
  final SocketService socketService;

  ChatRealtimeDataSourceImpl(this.socketService);

  @override
  void connect() {
    socketService.connect();
  }

  @override
  void disconnect() {
    socketService.disconnect();
  }

  @override
  void sendMessage(String message) {
    socketService.emit('message', message);
  }

  @override
  void onMessage(void Function(String) callback) {
    socketService.on('message', callback);
  }
}
