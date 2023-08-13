import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../view_model/auth_viewmodel.dart';
import '../view_model/message_viewmodel.dart';

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
  bool isFavorite = false;

  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _messageViewModel = Provider.of<MessageViewModel>(context, listen: false);
    super.initState();
  }

<<<<<<< HEAD
=======
  Future<void> removeFriend(String friendId) async {
    await _authViewModel.removeFriend(friendId);
  }

>>>>>>> Aakriti
  void toggleFavorite(String email) {
    setState(() {
      bool foundFav = false;
      for (int i = 0; i < _authViewModel.favoriteList.length; i++) {
        if (_authViewModel.favoriteList[i].email == email) {
          _authViewModel.removeFavorite(
            _authViewModel.loggedInUser!,
            _authViewModel.loggedInUser!.id!,
            email,
          );
          foundFav = true;
          break;
        }
      }
      if (!foundFav) {
        _authViewModel.addFavorite(
          _authViewModel.loggedInUser!,
          _authViewModel.loggedInUser!.id!,
          email,
        );
      }
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
<<<<<<< HEAD
              Navigator.pop(context);
=======
              Navigator.pop(context); // Close the dialog
>>>>>>> Aakriti
            },
            child: Text("No"),
          ),
          Consumer<AuthViewModel>(
            builder: (context, _authViewModel, child) => TextButton(
              onPressed: () async {
                final friend = _authViewModel.friendsList[widget.indexes];
                deleteMessage(
                    _authViewModel.loggedInUser!.id!, friend.id.toString());
                if (friend != null) {
                  removeFriend(friend.id.toString());
                }
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }

  void _hideConversation() {
    setState(() {
      _showCard = false;
    });
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
<<<<<<< HEAD
                      // Handle the tap action
=======
                      _messageViewModel.showMessages(
                          _authViewModel.loggedInUser!.id,
                          _authViewModel.friendsList[widget.indexes].id);

                      Navigator.pushNamed(context, '/chatscreen',
                          arguments: (_authViewModel.friendsList[widget.indexes]));
>>>>>>> Aakriti
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
>>>>>>> Aakriti
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "", // Add the appropriate subtitle
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
<<<<<<< HEAD
                            // Handle delete button press
=======
>>>>>>> Aakriti
                            _showDeleteConfirmationDialog(context);
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
<<<<<<< HEAD
                            // Handle hide button press
=======
>>>>>>> Aakriti
                            _hideConversation();
                          },
                          icon:
                          Icon(Icons.hide_source, color: Colors.white),
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
                          onTap: () => toggleFavorite(
                              _authViewModel.friendsList[widget.indexes]!
                                  .email!),
                          child: Icon(
                            isFavorite
                                ? Icons.star
                                : Icons.star_border,
                            color: isFavorite
                                ? Colors.yellow
                                : Colors.white,
>>>>>>> Aakriti
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
      ),
    );
  }
}
