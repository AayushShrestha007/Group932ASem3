import 'package:ez_text/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/auth_repositories.dart';

// class AuthViewModel with ChangeNotifier{
//
//   User? _user = FirebaseService.firebaseAuth.currentUser;
//   User? get user=> _user;
//
//   UserModel? _loggedInUser;
//   UserModel? get loggedInUser=>_loggedInUser;
//
//   List<UserModel> _friendsList= [];
//   List<UserModel> get friendsList=> _friendsList;
//
//
//
//   Future<void> register(UserModel user) async {
//     try {
//       var response = await AuthRepository().register(user);
//       _user = response!.user;
//       // _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
//       notifyListeners();
//     } catch (err) {
//       // AuthRepository().logout();
//       rethrow;
//     }
//   }
//
//   Future<void> login(String email, String password) async{
//     try{
//       var response= await AuthRepository().login(email, password);
//       _user = response.user;
//       _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
//       print(_loggedInUser?.myFriends);
//
//       await getFriendsDetail(_loggedInUser!.myFriends!);
//
//       notifyListeners();
//     } catch(err){
//       // AuthRepository().logout();
//       rethrow;
//     }
//   }
//
//
//
//   Future<void> addUser(UserModel model, String id, String email)  async{
//
//     try{
//       _loggedInUser= await AuthRepository().addUser(model, id, email);
//       if(_loggedInUser== null){
//         throw Exception("Email not found");
//       }
//       getFriendsDetail(loggedInUser!.myFriends!);
//
//   Future<void> addUser(UserModel model, String id, String email) async {
//     try {
//       _loggedInUser = await AuthRepository().addUser(model, id, email);
//
//       await getFriendsDetail(loggedInUser!.myFriends!);
//
//       notifyListeners();
//
//
//     } catch(err){
//       print("VM ERR :: " + err.toString());
//       rethrow;
//     }
//
//   }
//
//
//
//   Future<void> removeFriend(String friendId) async {
//     try {
//       await AuthRepository()
//           .removeFriend(loggedInUser!.id.toString(), friendId);
//       _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
//       notifyListeners();
//       await getFriendsDetail(loggedInUser!.myFriends!);
//       notifyListeners();
//     } catch (err) {
//       rethrow;
//     }
//   }
//
//
//   Future<void> getFriendsDetail(List<String> ids) async{
//     print(ids);
//     _friendsList= [];
//     for(int i=0; i< ids.length;i++){
//       var a= await AuthRepository().getUserDetailWithId(ids[i]);
//       if(a!=null){
//         _friendsList?.add(a);
//         print(_friendsList);
//       }
//
//     }
//     notifyListeners();
//   }
//
//
//   Future<void> changePassword(String password, String id) async {
//     try {
//       _loggedInUser?.password = password;
//       await AuthRepository().changePassword(password, _loggedInUser!);
//       print("wassup");
//
//
//   Future<void> changePassword(String password, String id) async {
//     try {
//       await AuthRepository().changePassword(password, id);
//       _loggedInUser?.password = password;
//
//       print(_loggedInUser?.password);
//       notifyListeners();
//     } catch (err) {
//       rethrow;
//     }
//   }
//
//
//   Future<void> updateProfileName(String name) async {
//     try {
//       _loggedInUser?.name = name;
//       await AuthRepository().updateUser(_loggedInUser!);
//       notifyListeners();
//     } catch (err) {
//       rethrow;
//     }
//   }
//
//
// }
//
//
// }



    class AuthViewModel with ChangeNotifier {
    User? _user = FirebaseService.firebaseAuth.currentUser;
    User? get user => _user;

    UserModel? _loggedInUser;
    UserModel? get loggedInUser => _loggedInUser;

    List<UserModel> _friendsList = [];
    List<UserModel> get friendsList => _friendsList;
    String? _token;
    String?  get token=>_token;
    Future<void> register(UserModel user) async {
    try {
    var response = await AuthRepository().register(user);
    _user = response!.user;
    // _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
    notifyListeners();
    } catch (err) {
    // AuthRepository().logout();
    rethrow;
    }
    }

    Future<void> login(String email, String password, String? token) async {
    try {
    var response = await AuthRepository().login(email, password);
    _user = response.user;
    _token = token;
    _loggedInUser = await AuthRepository().getUserDetail(_user!.uid, token);
    print(_loggedInUser?.myFriends);

    await getFriendsDetail(_loggedInUser!.myFriends!);
    // await MessageViewModel().showMessage();

    notifyListeners();
    } catch (err) {
    // AuthRepository().logout();
    rethrow;
    }
    }

    Future<void> addUser(UserModel model, String id, String email) async {
    try {
    _loggedInUser = await AuthRepository().addUser(model, id, email);

    await getFriendsDetail(loggedInUser!.myFriends!);
    notifyListeners();
    } catch (err) {
    rethrow;
    }
    }

    Future<void> removeFriend(String friendId) async {
    try {
    await AuthRepository()
        .removeFriend(loggedInUser!.id.toString(), friendId);
    _loggedInUser = await AuthRepository().getUserDetail(_user!.uid, _token);
    notifyListeners();
    await getFriendsDetail(loggedInUser!.myFriends!);
    notifyListeners();
    } catch (err) {
    rethrow;
    }
    }

    Future<void> getFriendsDetail(List<String> ids) async {
    print(ids);
    _friendsList = [];
    for (int i = 0; i < ids.length; i++) {
    var a = await AuthRepository().getUserDetailWithId(ids[i]);
    if (a != null) {
    _friendsList?.add(a);
    print(_friendsList);
    }
    }
    notifyListeners();
    }


    Future<void> changePassword(String password, String id) async {
    try {
    await AuthRepository().changePassword(password, id);
    _loggedInUser?.password = password;
    print(_loggedInUser?.password);
    notifyListeners();
    } catch (err) {
    rethrow;
    }
    }

    Future<void> updateProfileName(String name) async {
    try {
    _loggedInUser?.name = name;
    await AuthRepository().updateUser(_loggedInUser!);
    notifyListeners();
    } catch (err) {
    rethrow;
    }
    }


    }
