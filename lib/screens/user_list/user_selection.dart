import 'dart:developer';

import 'package:ez_text/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../view_model/auth_viewmodel.dart';



class UserSelection extends StatefulWidget {


  const UserSelection({Key? key}) : super(key: key);


  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {


    late AuthViewModel _authViewModel;

    void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      });
      super.initState();

    }

  static TextEditingController emailController= TextEditingController();


    Future<void> addChatUser(UserModel? model, String? id, String email) async {
   await _authViewModel.addUser(model!, id!, email);
}

    void _onDismissed(){

    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select User"),
      ),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xff4e91fb),
                height: MediaQuery.of(context).size.height - 200,
                width: double.infinity,

                child: Consumer<AuthViewModel>(

                  builder: (context, _authViewModel, child)=>


                  ListView.builder(


                    itemCount: _authViewModel.loggedInUser?.myFriends?.length,

                    itemBuilder: (context,index){
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                                onPressed: (context)=> _onDismissed(),
                              backgroundColor: Colors.red,
                              // icon: Icons.share,
                              label: 'Remove',
                            ),
                            SlidableAction(
                              onPressed: (context)=> _onDismissed(),
                              backgroundColor: Colors.yellow,
                              // icon: Icons.remove,
                              label: 'Block',
                            )
                          ],
                        ),
                        child: Padding(

                          padding: EdgeInsets.only(left: 10,right:10,top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xff1976D2)
                                ),
                              ),
                            ),
                            child: ListTile(

                              title: Text((_authViewModel!.friendsList![index])!.name!),
                                subtitle: Text((_authViewModel!.friendsList![index])!.email!),
                            ),
                          ),
                        ),
                      );
                      // return ListTile(
                      //
                      //   title: Text((_authViewModel!.friendsList![index])!.name!),
                      //   subtitle: Text((_authViewModel!.friendsList![index])!.email!),
                      // );
                    },
                  )
                )
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
                             borderRadius: BorderRadius.circular(50)
                            ),
                            hintText: " Enter email",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),


                      Consumer<AuthViewModel>(
                        builder: (context, AuthViewModel, child)=>
                        IconButton(
                            iconSize: 50,
                            color: Colors.white,

                            onPressed: () async{
                              if(emailController.text.isNotEmpty) {
                                await addChatUser(AuthViewModel.loggedInUser, AuthViewModel.loggedInUser!.id, emailController.text );

                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please enter a valid email")));
                              }
                        },

                            icon:Icon(Icons.add_circle) ),
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
        ),
      )
    );
  }
}
