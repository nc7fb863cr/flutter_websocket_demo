import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/view_models/app_model.dart';
import 'package:provider/provider.dart';

class MessageInput extends StatefulWidget {
  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _canSendMessage = false;
  AppModel _appModel;
  TextEditingController _controller;

  void _sendMessage() {
    if (_controller.text.trim() != "") {
      _appModel.sendMessage(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() => _canSendMessage = _controller.text.trim() != "");
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appModel ??= Provider.of<AppModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[500],
      padding: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 28),
      child: TextField(
        controller: _controller,
        onSubmitted: (_) => _sendMessage(),
        onEditingComplete: _sendMessage,
        style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            hintText: '請輸入訊息',
            isDense: true,
            filled: true,
            fillColor: Colors.grey[300],
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            suffixIcon: GestureDetector(
                onTap: _sendMessage,
                child: Icon(Icons.send, size: 28, color: _canSendMessage ? Colors.blue : Colors.grey)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none)),
      ),
    );
  }
}
