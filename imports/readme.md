***📌 1. Core Dart Imports***

| Import                               | Purpose                                                                                     |
| ------------------------------------ | ------------------------------------------------------------------------------------------- |
| `import 'dart:core';`                | Core Dart library (auto-imported). Includes `int`, `String`, `List`, `Map`, `print()`, etc. |
| `import 'dart:async';`               | Asynchronous programming: `Future`, `Stream`, `Timer`.                                      |
| `import 'dart:collection';`          | Advanced collections: `Queue`, `LinkedHashMap`, `HashSet`.                                  |
| `import 'dart:convert';`             | Encoding/decoding: JSON (`jsonEncode`, `jsonDecode`), UTF-8, Base64.                        |
| `import 'dart:io';`                  | File, socket, HTTP server, and OS I/O (Dart VM only, not Flutter Web).                      |
| `import 'dart:math';`                | Math utilities: constants (`pi`), functions (`sqrt()`), random numbers (`Random`).          |
| `import 'dart:typed_data';`          | Fixed-size binary lists (`Uint8List`) for raw byte handling.                                |
| `import 'dart:isolate';`             | Multi-threaded parallelism using isolates.                                                  |
| `import 'dart:developer';`           | Debugging, logging (`log()`), profiling.                                                    |
| `import 'dart:ffi';`                 | Call native C APIs via Foreign Function Interface (FFI).                                    |
| `import 'dart:html';`                | Web-specific DOM APIs (only for Dart web apps).                                             |
| `import 'dart:js';` / `dart:js_util` | JavaScript interop in Dart web apps.                                                        |
| `import 'dart:ui';`                  | Flutter’s low-level rendering engine (canvas, text layout, colors).                         |


***📌 2. Flutter Framework Imports ***


| Import                                      | Purpose                                                            |
| ------------------------------------------- | ------------------------------------------------------------------ |
| `import 'package:flutter/material.dart';`   | Material Design widgets & themes (buttons, cards, app bars, etc.). |
| `import 'package:flutter/cupertino.dart';`  | iOS-style Cupertino widgets (sliders, pickers, navigation bars).   |
| `import 'package:flutter/widgets.dart';`    | Core widget library without Material/Cupertino styling.            |
| `import 'package:flutter/foundation.dart';` | Constants/utilities: `kDebugMode`, `kIsWeb`, `ChangeNotifier`.     |
| `import 'package:flutter/rendering.dart';`  | Lower-level rendering for custom UI drawing.                       |
| `import 'package:flutter/services.dart';`   | Platform channels, clipboard, keyboard shortcuts, system services. |
| `import 'package:flutter/gestures.dart';`   | Gesture detection (tap, drag, pan, etc.).                          |
| `import 'package:flutter/animation.dart';`  | Animation classes (`AnimationController`, `Tween`, `Curves`).      |
| `import 'package:flutter/scheduler.dart';`  | Frame callbacks, animation scheduling, tickers.                    |
| `import 'package:flutter/painting.dart';`   | Styles, text spans, gradients, images, and color utilities.        |
| `import 'package:flutter/widgets.dart';`    | Core widget library without Material/Cupertino styling

***📌 3. Common Flutter Plugin Import ***

| Import                                                           | Purpose                                            |
| ---------------------------------------------------------------- | -------------------------------------------------- |
| `import 'package:shared_preferences/shared_preferences.dart';`   | Store small key-value pairs locally.               |
| `import 'package:http/http.dart';`                               | HTTP networking (GET, POST, PUT, DELETE).          |
| `import 'package:provider/provider.dart';`                       | Simple state management with dependency injection. |
| `import 'package:flutter_bloc/flutter_bloc.dart';`               | BLoC pattern for structured state management.      |
| `import 'package:equatable/equatable.dart';`                     | Value-based equality for cleaner comparisons.      |
| `import 'package:path/path.dart';`                               | File system path manipulation.                     |
| `import 'package:sqflite/sqflite.dart';`                         | SQLite database support.                           |
| `import 'package:hive/hive.dart';`                               | Lightweight NoSQL local storage.                   |
| `import 'package:image_picker/image_picker.dart';`               | Pick images/videos from gallery or camera.         |
| `import 'package:firebase_core/firebase_core.dart';`             | Initialize Firebase in Flutter.                    |
| `import 'package:cloud_firestore/cloud_firestore.dart';`         | Firebase Cloud Firestore database.                 |
| `import 'package:firebase_auth/firebase_auth.dart';`             | Firebase Authentication.                           |
| `import 'package:socket_io_client/socket_io_client.dart' as IO;` | Real-time communication with Socket.IO.            |
| `import 'package:connectivity_plus/connectivity_plus.dart';`     | Network connectivity status
