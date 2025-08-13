What It Is
The socket_io_client package is a Dart port of the popular JavaScript Socket.IO client library, enabling real-time, bidirectional and event-based communication with Socket.IO servers. It supports Flutter for iOS/Android and Dart VM environments—just ensure you're not targeting Flutter Web 


Why Use It
Real-time, ***low-latency communication without polling.***

Supports advanced Socket.IO features such as ***reconnection, acknowledgements, broadcasting, and namespaces***


Built-in ***fallback*** to long polling, though WebSocket is ***recommended for Flutter*** 


Where It’s Used
Ideal for enabling features like:

```
Real-time chat

Live notifications

Multiplayer interactions

Real-time dashboards or feeds

```

***How to Set Up and Use***

Setup

Add to your pubspec.yaml:

```
dependencies:
  socket_io_client: ^3.1.2

```

***Basic Connection***

import 'package:socket_io_client/socket_io_client.dart' as IO;

```
final socket = IO.io(
  'http://yourserver.com',
  IO.OptionBuilder()
    .setTransports(['websocket']) // mandatory in Flutter/Dart VM
    .disableAutoConnect() // manual connect control
    .build(),
);


socket.connect();

socket.onConnect((_) => print('Connected'));
socket.onDisconnect((_) => print('Disconnected'));
socket.on('eventName', (data) => print('Received: $data'));
socket.emit('eventName', {'key': 'value'});

```


Advanced Features
Emit with acknowledgment:

```
socket.emitWithAck('msg', 'init', ack: (data) => print('Ack: $data'));
Listen to built-in connection events: connect_error, reconnect, ping, pong, etc. 

```

Force new connections or disable multiplexing to avoid stale connections and header reuse issues 
Dart packages
.

Common Pitfalls & Solutions

|----------------------------------------------|----------------------------------------------------|
|Issue                                         |Solution                                            |
|----------------------------------------------|----------------------------------------------------|                              	
|Memory leak on iOS when using socket.close()  |Use socket.dispose() instead                        |
|                                              |                                                    |
|Self-signed certificate/HTTPS failure	       | Override HttpOverrides.badCertificateCallback      |
|                                              |to accept the certificate                           |
|                                              |                                                    |
|iOS networking permission issues on macOS	   |Add network entitlements:                           |
|                                              |<key>com.apple.security.network.client</key><true/> |
|Flutter Web not supported	                   |Official support is limited to Dart VM, not Web     |


Real-World Tips from the Community


“Memory leak on iOS was solved by using .dispose() instead of .disconnect().”
— Prefer .dispose() for clean teardown 


Template: Best Practices for Clean Usage

```
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  void init(String url, {Map<String, dynamic>? headers}) {
    _socket = IO.io(
      url,
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setExtraHeaders(headers ?? {})
        .enableForceNew()
        .build(),
    );

    _socket.onConnect((_) => print('Connected'));
    _socket.onDisconnect((_) => print('Disconnected'));
    _socket.onError((err) => print('Error: $err'));
  }

  void connect() => _socket.connect();

  void emit(String event, dynamic data, {Function? callback}) {
    callback != null
        ? _socket.emitWithAck(event, data, ack: callback)
        : _socket.emit(event, data);
  }

  void on(String event, Function(dynamic) handler) => _socket.on(event, handler);

  void dispose() => _socket.dispose();
}

```
Use in your app:

```
final socket = SocketService();
socket.init('http://yourserver.com', headers: {'x-token': token});
socket.connect();
socket.on('message', (data) { /* handle message */ });
...
socket.dispose();

```


We’ll go in three (3)  major parts:

```
Core Socket Setup (works everywhere except Web)

Platform-specific differences (Android, iOS, Desktop)

Advanced Patterns (reconnection strategy, error handling, BLoC integration, dependency injection)

```

***1️⃣ Core Socket Setup (Universal)***

Here’s a Best-of-the-Best clean implementation that works for Android, iOS, Windows, Linux, Mac:

```
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;
  bool _isConnected = false;

  void init({
    required String url,
    Map<String, dynamic>? headers,
  }) {
    _socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Required for Flutter/Dart
          .setExtraHeaders(headers ?? {})
          .disableAutoConnect() // You control when to connect
          .enableForceNew() // Avoid stale connections
          .build(),
    );

    _socket.onConnect((_) {
      _isConnected = true;
      print('[Socket] Connected ✅');
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      print('[Socket] Disconnected ❌');
    });

    _socket.onError((err) {
      print('[Socket] Error: $err');
    });

    _socket.onConnectError((err) {
      print('[Socket] Connect Error: $err');
    });

    _socket.onReconnect((attempt) {
      print('[Socket] Reconnected after $attempt attempts 🔄');
    });

    _socket.onReconnectAttempt((attempt) {
      print('[Socket] Reconnecting attempt $attempt...');
    });
  }

  void connect() {
    if (!_isConnected) {
      print('[Socket] Attempting connection...');
      _socket.connect();
    }
  }

  void emit(String event, dynamic data, {Function? ack}) {
    if (_isConnected) {
      ack != null
          ? _socket.emitWithAck(event, data, ack: ack)
          : _socket.emit(event, data);
    } else {
      print('[Socket] Cannot emit, not connected.');
    }
  }

  void on(String event, Function(dynamic) handler) {
    _socket.on(event, handler);
  }

  void off(String event) {
    _socket.off(event);
  }

  void disconnect() {
    _socket.disconnect();
    _isConnected = false;
  }

  void dispose() {
    _socket.dispose();
    _isConnected = false;
  }
}

```

2️⃣ Platform-Specific Details

📱 ***Android***
#### Add internet permission in android/app/src/main/AndroidManifest.xml:

```
<uses-permission android:name="android.permission.INTERNET"/>

```
WebSocket works without extra config.

If using self-signed HTTPS, ensure your Android client trusts the certificate.

📱 ***iOS***
Enable network permissions in ios/Runner/Info.plist:

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

```
If memory ***leak happens*** when disconnecting, use:

#### socket.dispose(); // instead of socket.disconnect()

If using macOS Catalyst, also add:

```
<key>com.apple.security.network.client</key>
<true/>

```

💻 Desktop (Windows/Linux/Mac)

NB

***No extra permission required.***


For self-signed HTTPS, override HTTP certificate checks:

```
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
}

```

3️⃣ Advanced Patterns

***A. Auto-Reconnection Strategy***

```
void initAutoReconnect({
  required String url,
  Duration retryDelay = const Duration(seconds: 5),
}) {
  init(url: url);

  _socket.onDisconnect((_) {
    Future.delayed(retryDelay, () {
      if (!_isConnected) {
        print('[Socket] Auto reconnecting...');
        connect();
      }
    });
  });
}

```

B. ***Integration with BLoC***

You can wrap Socket events inside a BLoC and dispatch events into UI:

```
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SocketService socketService;

  ChatBloc(this.socketService) : super(ChatInitial()) {
    on<ConnectSocket>((event, emit) {
      socketService.connect();
    });

    socketService.on('message', (data) {
      add(NewMessageReceived(data));
    });
  }
}

```

C. ***Dependency Injection***

Register SocketService as a singleton in GetIt or injectable:

```
final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton(() => SocketService());
}

```



Here’s a Best-of-the-Best socket_io_client Implementation for Flutter that is:

```

✅ Clean architecture ready (can go into your data layer’s real-time data source)

✅ Production safe (handles reconnections, errors, stale connections)

✅ Extensible (easy to plug into BLoC, Riverpod, or Provider)

✅ Cross-platform (Android, iOS, Web, Desktop)

✅ Testable (abstracted to allow mocking in unit tests)


```

1️⃣ The Socket Service (Universal, Production-Ready)


2️⃣ Example Usage (With Auto-Reconnect)

```
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

```

3️⃣ Clean Architecture Placement

***Data Layer → RealtimeDataSource:***

```
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

```
4️⃣ Common Mistakes to Avoid

Not disabling autoConnect → Can cause race conditions before listeners are set.

Forgetting to call dispose → Leads to memory leaks.

Reusing stale connections → Always use enableForceNew().

Not handling reconnection → In real-time apps, this is critical.

Not specifying ['websocket'] → Defaults to HTTP polling which is slower & less reliable in Flutter.

