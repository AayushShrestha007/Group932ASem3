import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';



class ChatUserCard extends StatefulWidget {
  final UserModel user;
  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // No shadow for the card
      color: Colors.transparent, // Make the card background transparent
      child: InkWell(
        onTap: ( ) {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
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
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: toggleFavorite,
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
    );
  }
}