import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Message {
  String id;
  String name;
  String message;
  String timestamp;

  Message({@required this.id, @required this.message, @required this.name, @required this.timestamp})
      : assert(id != null),
        assert(message != null),
        assert(name != null),
        assert(timestamp != null);

  factory Message.fromJson(Map<String, dynamic> json) {
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(json['timestamp']));
    return Message(id: json['id'], name: json['name'], message: json['message'], timestamp: formattedDate);
  }

  static String make({String user = 'User', String message = "", String id = ""}) {
    return json.encode({"name": user, "message": message, "id": id, "timestamp": DateTime.now().toString()});
  }
}
