import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/models/person.dart';
import 'package:flutter_websocket_demo/view_models/app_model.dart';
import 'package:provider/provider.dart';

class Avatar extends StatelessWidget {
  Avatar({@required this.person, @required this.selected});
  final Person person;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Provider.of<AppModel>(context, listen: false).setAvatar(person),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: selected ? Border.all(color: Colors.blue, width: 3) : null),
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            ClipOval(child: Image.asset(person.avatar)),
            SizedBox(height: 8),
            Text(person.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ]),
        ),
      ),
    );
  }
}
