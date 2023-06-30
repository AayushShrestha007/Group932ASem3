import 'package:ez_text/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _blueMessage(){
    return Container();
  }

  Widget _greenMessage(){
    return Container();
  }
}
