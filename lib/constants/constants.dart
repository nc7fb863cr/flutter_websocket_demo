import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/models/person.dart';

class Constants {
  static const route = "wss://192.168.0.3:6000";
  static const List<Color> myGradientColorSet = [Color(0xFF19B7FF), Color(0xFF491CCB)];
  static const List<Color> othersGradientColorSet = [Color(0xFFE0AAFF), Color(0xFF5A189A)];

  static List<Person> figures = [
    Person(name: 'Alex', avatar: 'assets/Alex.png'),
    Person(name: 'Joe', avatar: 'assets/Joe.png'),
    Person(name: 'Amy', avatar: 'assets/Amy.png'),
    Person(name: 'Eva', avatar: 'assets/Eva.png'),
  ];
}
