import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/message_card.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../view_model/auth_viewmodel.dart';
import '../../view_model/message_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late MessageViewModel _messageViewModel;
  late AuthViewModel _authViewModel;
  bool isOnline = true;
  UserModel? receiverUserModel;

  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _messageViewModel = Provider.of<MessageViewModel>(context, listen: false);
      setState(() {
        receiverUserModel =
        ModalRoute.of(context)?.settings.arguments as UserModel?;
      });
    });
    super.initState();
  }

  Future<void> sendMessage(String msg, String fromId, String toId) async {
    try {
      await _messageViewModel.sendMessage(msg, fromId, toId);
      _messageController.clear();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffc6c2c2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          flexibleSpace: _appBar(),
        ),
        body: receiverUserModel == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 170,
                child: Consumer<MessageViewModel>(
                  builder: (context, _messageViewModel, child) =>
                      StreamBuilder<QuerySnapshot>(
                        stream: _messageViewModel.messages,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              print("wassup");
                              final data = snapshot.data?.docs;
                              print(data?.first.runtimeType);
                              final list = ["hello", "jello", "sup"];

                              if (list.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: data?.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(
                                      receiverUser: receiverUserModel!,
                                      message: MessageModel(
                                        fromId: data?[index]["fromID"],
                                        msg: data?[index]["msg"],
                                        read: data?[index]["read"],
                                        sent: data?[index]["sent"],
                                        toId: data?[index]["toID"],
                                        type: data?[index]["type"],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "Say Hiii 👋",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                );
                              }
                          }
                        },
                      ),
                ),
              ),
              _chatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Back button
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 30,
          child: Icon(CupertinoIcons.person),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${receiverUserModel?.name ?? 'Loading'}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    isOnline ? "Online" : "Offline",
                    style: TextStyle(
                      fontSize: 12,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 20,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatInput() {
    final mq = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Colors.blueAccent,
                    size: 25,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Write a message....',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.image,
                    color: Colors.blueAccent,
                    size: 26,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.blueAccent,
                    size: 26,
                  ),
                ),
                SizedBox(width: mq * .02),
              ],
            ),
          ),
        ),
        Consumer<AuthViewModel>(
          builder: (context, _authViewModel, child) => MaterialButton(
            onPressed: () {
              sendMessage(_messageController.text,
                  _authViewModel.loggedInUser!.id!, receiverUserModel!.id!);
            },
            minWidth: 0,
            padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
            shape: const CircleBorder(),
            color: Colors.blueAccent,
            child: const Icon(
              Icons.arrow_forward_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
