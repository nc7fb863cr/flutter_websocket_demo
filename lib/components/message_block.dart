import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/components/bubble_background.dart';
import 'package:flutter_websocket_demo/constants/constants.dart';
import 'package:flutter_websocket_demo/models/message.dart';
import 'package:flutter_websocket_demo/view_models/app_model.dart';
import 'package:provider/provider.dart';

class MessageBlock extends StatefulWidget {
  MessageBlock({@required this.id, @required this.message});
  final String id;
  final Message message;

  @override
  State<MessageBlock> createState() => _MessageBlockState();
}

class _MessageBlockState extends State<MessageBlock> {
  Widget _buildSelfBlock() => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BubbleBackground(
          colors: Constants.myGradientColorSet,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(widget.message.message, style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
      );

  Widget _buildOthersBlock() => ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BubbleBackground(
          colors: Constants.othersGradientColorSet,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(widget.message.message, style: TextStyle(fontSize: 20, color: Colors.white)),
          )));

  Widget _buildHeader(bool messageSentByCurrentUser) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: messageSentByCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: messageSentByCurrentUser ? Colors.blue : Colors.purple[300], width: 3)),
              child: ClipOval(child: Image.asset(context.read<AppModel>().person.avatar, width: 20, height: 20))),
          SizedBox(width: 4),
          Text(widget.message.name,
              style: TextStyle(
                  fontSize: 20,
                  color: messageSentByCurrentUser ? Colors.blue : Colors.purple[300],
                  fontWeight: FontWeight.bold)),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    final messageSentByCurrentUser = widget.id == widget.message.id;
    return Container(
        width: MediaQuery.of(context).size.width * .7,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: messageSentByCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            _buildHeader(messageSentByCurrentUser),
            SizedBox(height: 4),
            messageSentByCurrentUser ? _buildSelfBlock() : _buildOthersBlock(),
            SizedBox(height: 4),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(widget.message.timestamp, style: TextStyle(fontSize: 14))),
          ],
        ));
  }
}
