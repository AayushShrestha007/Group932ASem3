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

  const ChatUserCard({Key? key, required this.user, required this.indexes})
      : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  late AuthViewModel _authViewModel;
  late MessageViewModel _messageViewModel;
  bool _showCard = true;
  bool _showButtons = false;

  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _messageViewModel = Provider.of<MessageViewModel>(context, listen: false);
    super.initState();
  }

<<<<<<< HEAD
=======
  bool isFavorite= false;
  bool _showButtons = false;


  Future<void> removeFriend(String friendId) async {
    await _authViewModel.removeFriend(friendId);
  }

  Future<void> deleteMessage(String fromId, String toId) async {
    await _messageViewModel.deleteMessage(fromId, toId);
  }


>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
  void toggleFavorite(String email) {
    setState(() {
      bool foundFav = false;
      for (int i = 0; i < _authViewModel.favoriteList.length; i++) {
        if (_authViewModel.favoriteList[i].email == email) {
          _authViewModel.removeFavorite(
            _authViewModel!.loggedInUser!,
            _authViewModel!.loggedInUser!.id!,
            email,
          );
          foundFav = true;
          break;
        }
      }
      if (!foundFav) {
        _authViewModel.addFavorite(
          _authViewModel!.loggedInUser!,
          _authViewModel!.loggedInUser!.id!,
          email,
        );
      }
    });
  }

<<<<<<< HEAD
=======

>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Messages"),
        content: Text("Are you sure you want to delete the messages?"),
        actions: [
          TextButton(
            onPressed: () {
<<<<<<< HEAD
=======
              // Close the dialog
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
          Consumer<AuthViewModel>(
<<<<<<< HEAD
            builder: (context, _authViewModel, child) => TextButton(
              onPressed: () async {
                final friend = _authViewModel.friendsList[widget.indexes];
                deleteMessage(_authViewModel!.loggedInUser!.id!, friend.id.toString());
                if (friend != null) {
                  removeFriend(friend.id.toString());
                }
                Navigator.pop(context);
=======
            builder: (context, _authViewModel, child)=> TextButton(
              onPressed: () async{
                final friend = _authViewModel.friendsList[widget.indexes];
                deleteMessage(_authViewModel!.loggedInUser!.id!, friend.id.toString());
                if ( friend!= null) {
                  removeFriend(friend.id.toString()); // Use 'id' instead of friend[id]
                }


                Navigator.pop(context);

>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
              },
              child: Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  void _hideConversation() {
    setState(() {
      _showCard = false;
    });
  }

  Future<void> removeFriend(String friendId) async {
    await _authViewModel.removeFriend(friendId);
  }

  Future<void> deleteMessage(String fromId, String toId) async {
    await _messageViewModel.deleteMessage(fromId, toId);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _showCard,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            _showButtons = true;
          });
        },
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      // Handle the tap action
=======

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        setState(() {
          _showButtons= true;
        });
      },
      child: Card(
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
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
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
<<<<<<< HEAD
                      widget.user.name ?? '',
=======
                      widget.user?.name ?? '',
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
<<<<<<< HEAD
                      "", // Add the appropriate subtitle
=======
                      // _messageViewModel.lastFromMessage,
                      // _authViewModel.lastMessage[_authViewModel.friendsList[widget.indexes].id].toString(),
                      "",
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
<<<<<<< HEAD
                    trailing: _showButtons
=======
                    trailing:_showButtons
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle delete button press
<<<<<<< HEAD
=======

>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
                            _showDeleteConfirmationDialog(context);
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle hide button press
<<<<<<< HEAD
                            _hideConversation();
=======
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
                          },
                          icon: Icon(Icons.hide_source, color: Colors.white),
                        ),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
<<<<<<< HEAD
                          onTap: () =>
                              toggleFavorite(_authViewModel!.friendsList[widget.indexes]!.email!),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.white,
=======
                          onTap: ()=> toggleFavorite(_authViewModel!.friendsList[widget.indexes]!.email!),
                          child: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.yellow : Colors.white,
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
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
<<<<<<< HEAD
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1.0,
                    indent: 16.0,
                    endIndent: 16.0,
                  ),
                ],
              ),
=======
                  );
                }),
                Divider(
                  color: Colors.white,
                  thickness: 1.0,
                  indent: 16.0,
                  endIndent: 16.0,
                ),
              ],
>>>>>>> 8b70671c6186ba80609be275f8d5ff9cdb54d850
            ),
          ),
        ),
      ),
    );
  }
}
