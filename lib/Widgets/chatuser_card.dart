import 'package:ez_text/repositories/message_repositories.dart';
import 'package:ez_text/view_model/message_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../view_model/auth_viewmodel.dart';

class ChatUserCard extends StatefulWidget {
  final UserModel user;
  final int indexes;
  // final MessageModel message;
  const ChatUserCard({Key? key, required this.user, required this.indexes})
      : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  late AuthViewModel _authViewModel;
  late MessageViewModel _messageViewModel;

  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  bool isFavorite= false;

  void toggleFavorite(String email) {
    setState(() {
      // for(int i=0; i< _authViewModel.favoriteList.length;i++){
      //   if(_authViewModel.favoriteList[i].email==email){
      //     print(1);
      //     _authViewModel.removeFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);
      //
      //   }
      //
      //   else{
      //     print(2);
      //     _authViewModel.addFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);
      //   }
      // }
      _authViewModel.addFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // No shadow for the card
      color: Colors.transparent, // Make the card background transparent
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Consumer<MessageViewModel>(
                  builder: (context, _messageViewModel, child) {
                    // MessageRepository().showLastFromMessage(_authViewModel!.loggedInUser!.id,
                    //     _authViewModel!.friendsList[widget.indexes].id);
                return ListTile(
                  onTap: () {
                    _messageViewModel.showMessages(
                        _authViewModel!.loggedInUser!.id,
                        _authViewModel!.friendsList[widget.indexes].id);

                    Navigator.pushNamed(context, '/chatscreen',
                        arguments:
                            (_authViewModel.friendsList[widget.indexes]));
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    widget.user?.name ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    // _messageViewModel.lastFromMessage,
                    _authViewModel.lastMessage[_authViewModel.friendsList[widget.indexes].id].toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: ()=> toggleFavorite(_authViewModel!.friendsList[widget.indexes]!.email!),
                        child: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: isFavorite ? Colors.yellow : Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "12:00 PM",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Divider(
                color: Colors.white,
                thickness: 1.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
