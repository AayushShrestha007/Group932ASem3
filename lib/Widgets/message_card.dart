import 'package:ez_text/models/message_model.dart';
import 'package:ez_text/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../view_model/message_viewmodel.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.receiverUser, required this.message}) : super(key: key);

  final UserModel? receiverUser;
  final MessageModel message;


  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  late AuthViewModel _authViewModel;
  late MessageViewModel _messageViewModel;

  void initState(){
    _authViewModel= Provider.of<AuthViewModel>(context, listen: false);


    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return Consumer<AuthViewModel>(
        builder: (context, _authViewModel, child){
          if(widget.receiverUser!.id == widget.message.toId || widget.receiverUser!.id== widget.message.fromId ){
            if(widget.message.fromId== _authViewModel.loggedInUser!.id || widget.message.fromId==widget.receiverUser!.id){
              return _authViewModel.loggedInUser!.id == widget.message.fromId ? _whiteMessage(): _blueMessage();
            }
            else{
              return SizedBox(height: 0);
            }

          }

          else{
            return SizedBox(height: 0);
          }


    }

    );


  }

  Widget _blueMessage(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(color: Colors.blue,
              border: Border.all(color: Color(0xff2977f6)),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
              )),
              child: Text(widget.message.msg as String,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              )),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 30),
          ),
        ],
      ),
    );

  }

  Widget _whiteMessage(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 30),
              ),


          Flexible(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Text(widget.message.msg as String,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
