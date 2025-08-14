1. Dart Core Imports (No extra installation needed)

These are part of the Dart SDK.

|Import                         |	Purpose
|-------------------------------|--------------------------------------------------------------------------------------------------------|
| import 'dart:core';	        | Core Dart library (imported automatically). Contains basic typeslike |int, String, List, Map,and core  |functions like print().
                                |                                                                                                        |
|import 'dart:async';	        | For asynchronous programming — includes Future, Stream, Timer, etc.                                    |
|import 'dart:collection';	    | Advanced collection types like Queue, LinkedHashMap, HashSet.                                          |
| import 'dart:convert';	    | Encode/decode JSON, UTF-8, Base64, etc.                                                                |
|                               | Example: jsonEncode(),  jsonDecode().                                                                  |
| import 'dart:io';	            | File, socket, HTTP server, and OS-level I/O (works only in Dart                                        |
                                | VM,  not in Flutter Web).                                                                              |
|import 'dart:math';	        | Math functions/constants: pi, sqrt(), Random().                                                        |
|import 'dart:typed_data';	    | Special fixed-size binary lists like Uint8List for working with raw bytes.                             |
|import 'dart:isolate';	        | Multi-threaded parallelism with isolates (Dart’s concurrency model).                                   |
|import 'dart:developer';	    | Debugging tools, profiling, logging (log()).                                                           |
|import 'dart:ffi';	            | Foreign Function Interface for calling native C APIs.                                                  |
|import 'dart:html';	        | Web-specific DOM APIs (only works in web apps).                                                        |
|mport 'dart:js';               | / dart:js_util	Interop with JavaScript in Dart web apps.                                            |
|import 'dart:ui';	            | Low-level Flutter rendering API (colors, canvas, text layout).                                         |


2. Flutter Framework Imports

These come with the Flutter SDK.

Import	Purpose
import 'package:flutter/material.dart';	Material Design widgets and themes (buttons, cards, app bars, etc.).
import 'package:flutter/cupertino.dart';	iOS-style Cupertino widgets (sliders, pickers, navigation bars).
import 'package:flutter/widgets.dart';	Core Flutter widget library without Material/Cupertino styling.
import 'package:flutter/foundation.dart';	Core Flutter constants and utilities like kDebugMode, kIsWeb, ChangeNotifier.
import 'package:flutter/rendering.dart';	Lower-level rendering objects for custom UI drawing.
import 'package:flutter/services.dart';	Access to platform channels, clipboard, keyboard shortcuts, and system services.
import 'package:flutter/gestures.dart';	Gesture detection (tap, drag, pan, etc.) for custom recognizers.
import 'package:flutter/animation.dart';	Flutter animation classes (AnimationController, Tween, Curves).
import 'package:flutter/scheduler.dart';	Frame callbacks, scheduling animations, Ticker.
import 'package:flutter/painting.dart';	Styles, text spans, image handling, colors, gradients.
3. Common Flutter Plugin Imports (Installed from pub.dev)

These depend on your pubspec.yaml.

Import	Purpose
import 'package:shared_preferences/shared_preferences.dart';	Store small amounts of key-value data locally.
import 'package:http/http.dart';	HTTP networking (GET, POST, etc.).
import 'package:provider/provider.dart';	Simple state management via dependency injection.
import 'package:flutter_bloc/flutter_bloc.dart';	BLoC (Business Logic Component) pattern for state management.
import 'package:equatable/equatable.dart';	Makes objects comparable by value for clean equality checks.
import 'package:path/path.dart';	File system path manipulation.
import 'package:sqflite/sqflite.dart';	SQLite database support.
import 'package:hive/hive.dart';	Lightweight NoSQL local storage.
import 'package:image_picker/image_picker.dart';	Pick images/videos from gallery or camera.
import 'package:firebase_core/firebase_core.dart';	Initialize Firebase in Flutter.
import 'package:cloud_firestore/cloud_firestore.dart';	Access Firebase Cloud Firestore database.
import 'package:firebase_auth/firebase_auth.dart';	Firebase Authentication.
import 'package:socket_io_client/socket_io_client.dart' as IO;	Real-time communication using Socket.IO.
4. Special-Purpose Imports

For specific workflows.

Import	Purpose
import 'package:flutter_test/flutter_test.dart';	Unit/widget testing in Flutter.
import 'package:mockito/mockito.dart';	Mocking dependencies for testing.
import 'package:flutter_localizations/flutter_localizations.dart';	Multi-language/localization support.
import 'package:flutter_svg/flutter_svg.dart';	Render SVG images in Flutter.
import 'package:go_router/go_router.dart';	Declarative navigation and routing.
import 'package:get/get.dart';	GetX state management and routing.