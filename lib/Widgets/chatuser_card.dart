import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../repositories/message_repositories.dart';
import '../screens/chat/chat_screen.dart';
import '../view_model/auth_viewmodel.dart';
import '../view_model/message_viewmodel.dart';

class ChatUserCard extends StatefulWidget {
  final UserModel? user;
  final String fromId;
  final String toId;

  final int indexes;



  ChatUserCard({Key? key, required this.user,  required this.indexes, required this.fromId,
    required this.toId,}) : super(key: key);



  @override
  _ChatUserCardState createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

  late AuthViewModel _authViewModel;
  late MessageViewModel _messageViewModel;

  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }


  bool _showButtons = false;
  bool _isFavorite = false;

  void toggleFavorite(String email) {
    setState(() {
      bool foundFav= false;
      for(int i=0; i< _authViewModel.favoriteList.length;i++){
        print(_authViewModel.favoriteList[i].email);
        if(_authViewModel.favoriteList[i].email==email){
          print(1);
          _authViewModel.removeFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);
          foundFav=true;
          break;
        }
      }
      if(!foundFav){
        print(2);
        _authViewModel.addFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);
      }

      // print(2);
      // _authViewModel.addFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);

      // _authViewModel.addFavorite(_authViewModel!.loggedInUser!, _authViewModel!.loggedInUser!.id!, email);
      // isFavorite = !isFavorite;
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Messages"),
        content: Text("Are you sure you want to delete the messages?"),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () async{
              await MessageRepository().deleteConversation(
                  widget.fromId, widget.toId

              );
              Navigator.pop(context);


            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _showButtons = true;
        });
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to chat screen
            // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Consumer<MessageViewModel>(
                  builder: (context, _messageViewModel, child) {
                    return ListTile(
                      onTap: () {
                        _messageViewModel.showMessages(_authViewModel!
                            .loggedInUser!.id,
                            _authViewModel.friendsList[widget.indexes].id);
                        Navigator.pushNamed(context, '/chatscreen',
                            arguments: (_authViewModel.friendsList[widget
                                .indexes]));
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
                        // _authViewModel.lastMessage[_authViewModel.friendsList[widget.indexes].id].toString(),
                        "",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                      trailing: _showButtons
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle delete button press

                              _showDeleteConfirmationDialog(context);
                            },
                            icon: Icon(Icons.delete, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle hide button press
                            },
                            icon: Icon(Icons.hide_source, color: Colors.white),
                          ),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                toggleFavorite(
                                    _authViewModel!.friendsList[widget.indexes]!
                                        .email!),
                            child: Icon(
                              _isFavorite ? Icons.star : Icons.star_border,
                              color: _isFavorite ? Colors.yellow : Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
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
      ),
    );
  }
}
