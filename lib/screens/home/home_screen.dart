import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/services/firebase_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/chatuser_card.dart';
import '../../models/user_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  List<UserModel> list = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                text: 'Status',
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseService.db.collection("users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.data?.docs;
              list = data?.map((e) => UserModel.fromJson(e.data()! as Map<String, dynamic>)).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index]);
                  },
                );
              }else{
                return Center(
                    child: Text("No Users Found",
                        style:TextStyle(fontSize: 40))
                );
              }

              return Container(); // Return an empty container if the list is empty
            },
          ),
          Container(
            color: Colors.blueAccent,
            child: Center(
              child: Text('Status'),
            ),
          ),
        ],
      ),
    );
  }
}