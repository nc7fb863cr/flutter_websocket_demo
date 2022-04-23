import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/constants/constants.dart';
import 'package:flutter_websocket_demo/models/message.dart';
import 'package:flutter_websocket_demo/models/person.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:math';

class AppModel extends ChangeNotifier {
  AppModel()
      : id = Random().nextDouble().toString(),
        messages = [],
        person = Constants.figures.first,
        host = Constants.route,
        name = Constants.figures.first.name;

  final String id;
  final List<Message> messages;

  String name;
  String host;
  Person person;
  WebSocketChannel channel;

  void initConnection() {
    channel = WebSocketChannel.connect(Uri.parse(host));
    channel.stream.listen((event) {
      // print([event, event.runtimeType]);
      messages.add(Message.fromJson(json.decode(event)));
      notifyListeners();
    });
  }

  void setAvatar(Person inputPerson) {
    person = inputPerson;
    notifyListeners();
  }

  void closeConnection() {
    messages.clear();
    channel.sink.close();
  }

  void sendMessage(String message) {
    final outputData = Message.make(user: name, message: message, id: id);
    channel.sink.add(outputData);
  }
}
