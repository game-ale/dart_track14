final socketService = SocketService(
  url: 'https://your-socket-server.com',
  headers: {'Authorization': 'Bearer YOUR_TOKEN'},
);

void main() {
  socketService.init();
  socketService.connect();

  socketService.on('message', (data) {
    print('📩 Message received: $data');
  });

  socketService.emit('join_room', {'roomId': '12345'});
}
