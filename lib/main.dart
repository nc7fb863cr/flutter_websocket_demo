import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/screens/entry_screen.dart';
import 'package:flutter_websocket_demo/view_models/app_model.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, appBarTheme: AppBarTheme(brightness: Brightness.dark)),
      home: ChangeNotifierProvider(create: (_) => AppModel(), child: EntryScreen()),
    );
  }
}
