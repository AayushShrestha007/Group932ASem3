import 'package:ez_text/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/auth_repositories.dart';
import '../repositories/message_repositories.dart';
import 'message_viewmodel.dart';

class AuthViewModel with ChangeNotifier {
  User? _user = FirebaseService.firebaseAuth.currentUser;
  User? get user => _user;

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;



  List<UserModel> _friendsList = [];
  List<UserModel> get friendsList => _friendsList;


  List<UserModel> _favoriteList = [];
  List<UserModel> get favoriteList => _favoriteList;

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

  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      print(_loggedInUser?.myFriends);

      await getFriendsDetail(_loggedInUser!.myFriends!);

      await getFavoriteDetail(_loggedInUser!.myFavorite!);




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


  Future<void> addFavorite(UserModel model, String id, String email) async {
    try {
      _loggedInUser = await AuthRepository().addFavorite(model, id, email);

      await getFavoriteDetail(loggedInUser!.myFavorite!);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }


  Future<void> getFavoriteDetail(List<String> ids) async {
    print(ids);
    _favoriteList = [];
    for(int i=0; i< ids.length;i++){
      var a= await AuthRepository().getUserDetailWithId(ids[i]);
      if(a!=null){
        _favoriteList?.add(a);
        print(_favoriteList);
      }

    }
    notifyListeners();
  }

  Future<void> removeFriend(String friendId) async {
    try {
      await AuthRepository()
          .removeFriend(loggedInUser!.id.toString(), friendId);
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      notifyListeners();
      await getFriendsDetail(loggedInUser!.myFriends!);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
  Map<String, String> _lastMessage = {};
  Map<String, String> get  lastMessage => _lastMessage;

  Future<void> getFriendsDetail(List<String> ids) async {
    print(ids);
    _friendsList = [];
    for(int i=0; i< ids.length;i++){
      var a= await AuthRepository().getUserDetailWithId(ids[i]);
      if(a!=null){
        _friendsList?.add(a);
        print(_friendsList);
      }

    }
    // for (int i = 0; i < ids.length; i++) {
    //   var a = await AuthRepository().getUserDetailWithId(ids[i]);
    //   var b = await MessageRepository().showLastFromMessage( _loggedInUser!.id, ids[i]);
    //   if(b!= null){
    //     lastMessage[ids[i]] = b;
    //   }
    //   if (a != null) {
    //     _friendsList?.add(a);
    //     print(_friendsList);
    //   }
    // }
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




}
