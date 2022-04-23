import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/components/dismissible_scope.dart';
import 'package:flutter_websocket_demo/components/message_block.dart';
import 'package:flutter_websocket_demo/components/message_input.dart';
import 'package:flutter_websocket_demo/models/message.dart';
import 'package:flutter_websocket_demo/view_models/app_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AppModel _appModel;
  List<Message> _messageList;

  @override
  void didChangeDependencies() {
    _appModel = Provider.of<AppModel>(context);
    _messageList = _appModel.messages;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _appModel.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissibleScope(
      child: Scaffold(
        appBar: AppBar(title: Text('Let\'s Chat'), centerTitle: true),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          _messageList.map((message) => MessageBlock(id: _appModel.id, message: message)).toList()))),
          MessageInput()
        ]),
      ),
    );
  }
}
