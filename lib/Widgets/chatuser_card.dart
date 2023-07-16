import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../repositories/message_repositories.dart';
import '../screens/chat/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final UserModel? user;
  final String fromId;
  final String toId;

  const ChatUserCard({Key? key, required this.user,  required this.fromId,
    required this.toId,}) : super(key: key);

  @override
  _ChatUserCardState createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  bool _showButtons = false;
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
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
            Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                ListTile(
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
                    "The Last Message",
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
                        onTap: _toggleFavorite,
                        child: Icon(
                          _isFavorite ? Icons.star : Icons.star_border,
                          color: _isFavorite ? Colors.yellow : Colors.white,
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
