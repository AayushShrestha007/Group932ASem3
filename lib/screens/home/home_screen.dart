import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/services/firebase_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../Widgets/chatuser_card.dart';
import '../../models/user_model.dart';
import '../../view_model/auth_viewmodel.dart';
import '../../view_model/message_viewmodel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  late AuthViewModel _authViewModel;
  late MessageViewModel _messageViewModel;


  static TextEditingController emailController= TextEditingController();



  List<UserModel> list = [];



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _messageViewModel= Provider.of<MessageViewModel>(context, listen: false);
    });

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  Future<void> addChatUser(UserModel? model, String? id, String email) async {
    try{

      await _authViewModel.addUser(model!, id!, email);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("a user with this email does not exist")));

    }
  }


  Future<void> removeFriend(String friendId) async {
    await _authViewModel.removeFriend(friendId);
  }

  void _onDismissed() {
    // TODO: Implement onDismissed logic if needed
  }


  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4F91FB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(CupertinoIcons.person),
              ),
              SizedBox(width: 10),
              Text(
                "EZText",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () {
                  // Handle search icon press
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),

              child: IconButton(
                onPressed: () {
                  // Handle menu icon press
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),

            ),

          ],

          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Chats',
              ),
              Tab(
                text: 'Add User',
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),

              Text("Favorites",
                style: TextStyle(
                  color: Colors.white
                ),

              ),

              Container(
                color: Color(0xff4e91fb),
                height: MediaQuery.of(context).size.height - 500,
                width: double.infinity,
                child: Consumer<AuthViewModel>(
                  builder: (context, _authViewModel, child) => ListView.builder(
                    itemCount: _authViewModel.favoriteList.length,
                    itemBuilder: (context, index) {
                      final fromId = _authViewModel.loggedInUser?.id ?? ''; // Replace with the actual current user ID
                      final toId = _authViewModel.friendsList[index].id ?? '';
                      return ChatUserCard(user: _authViewModel.favoriteList[index],indexes: index );

                    },
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Text("Conversation",
                style: TextStyle(
                    color: Colors.white
                ),

              ),

              Container(
                color: Color(0xff4e91fb),
                height: MediaQuery.of(context).size.height - 500,
                width: double.infinity,
                child: Consumer<AuthViewModel>(
                  builder: (context, _authViewModel, child) => ListView.builder(
                    itemCount: _authViewModel.friendsList.length,
                    itemBuilder: (context, index) {
                      final fromId = _authViewModel.loggedInUser?.id ?? ''; // Replace with the actual current user ID
                      final toId = _authViewModel.friendsList[index].id ?? '';
                      return ChatUserCard(user: _authViewModel.friendsList[index], indexes: index  );

                    },
                  ),
                ),
              ),
            ],
          ),


          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseService.db.collection("users").snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //
          //     final data = snapshot.data?.docs;
          //     list = data?.map((e) => UserModel.fromJson(e.data()! as Map<String, dynamic>)).toList() ?? [];
          //
          //     if (list.isNotEmpty) {
          //       return ListView.builder(
          //         itemCount: list.length,
          //         physics: BouncingScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           return ChatUserCard(user: list[index]);
          //         },
          //       );
          //     }else{
          //       return Center(
          //           child: Text("No Users Found",
          //               style:TextStyle(fontSize: 40))
          //       );
          //     }
          //
          //     return Container(); // Return an empty container if the list is empty
          //   },
          // ),
          SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  color: Color(0xff4e91fb),
                  height: MediaQuery.of(context).size.height - 200,
                  width: double.infinity,
                  child: Consumer<AuthViewModel>(
                    builder: (context, _authViewModel, child) => ListView.builder(
                      itemCount: _authViewModel.friendsList.length,
                      itemBuilder: (context, index) {
                        final friend = _authViewModel.friendsList[index];
                        print("FRIENDS" +friend.toString());
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  if (friend != null) {
                                    removeFriend(friend.id.toString()); // Use 'id' instead of friend[id]
                                  }
                                },
                                backgroundColor: Colors.red,
                                label: 'Remove',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  _onDismissed();
                                },
                                backgroundColor: Colors.yellow,
                                label: 'Block',
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xff1976D2)),
                                ),
                              ),
                              child: ListTile(

                                onTap: (){
                                  _messageViewModel.showMessages( _authViewModel!.loggedInUser!.id,  _authViewModel!.friendsList[index].id );


                                  Navigator.pushNamed(context, '/chatscreen',arguments: ( _authViewModel.friendsList[index]));

                                },
                                title: Text(
                                  ( _authViewModel.friendsList[index]).name.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  ( _authViewModel.friendsList[index]).email.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xff4e91fb),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: "Enter email",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Consumer<AuthViewModel>(
                          builder: (context, AuthViewModel, child) => IconButton(
                            iconSize: 50,
                            color: Colors.white,
                            onPressed: () async {
                              if (emailController.text.isNotEmpty) {
                                await addChatUser(
                                  AuthViewModel.loggedInUser,
                                  AuthViewModel.loggedInUser?.id,
                                  emailController.text,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Please enter a valid email")),
                                );
                              }
                            },
                            icon: Icon(Icons.add_circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}