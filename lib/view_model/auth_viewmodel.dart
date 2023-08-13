import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/auth_repositories.dart';

class AuthViewModel with ChangeNotifier {
  User? _user;
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
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      await getFriendsDetail(_loggedInUser!.myFriends!);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addUser(UserModel model, String id, String email) async {
    try {
      _loggedInUser =
      await AuthRepository().addUser(model, id, email);
      if (_loggedInUser == null) {
        throw Exception("Email not found");
      }
      await getFriendsDetail(loggedInUser!.myFriends!);
      notifyListeners();
    } catch (err) {
      print("VM ERR :: " + err.toString());
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

  Future<void> addFavorite(UserModel model, String id, String email) async {
    try {
      _loggedInUser = await AuthRepository().addFavorite(model, id, email);

      await getFavoriteDetail(loggedInUser!.myFavorite!);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> removeFavorite(UserModel model, String id, String email) async {
    try {
      _loggedInUser = await AuthRepository().removeFavorite(model, id, email);

      await getFavoriteDetail(_loggedInUser!.myFavorite!);
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



  Future<void> changePassword(String password, String id) async {
    try {
      await AuthRepository().changePassword(password, id);
      _loggedInUser?.password = password;
      print("wassup");
      print(_loggedInUser?.password);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<String?> uploadProfileImage(File image) async {
    try {
      String? imageUrl =
      await AuthRepository().uploadProfileImage(image, loggedInUser!);
      return imageUrl;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      await AuthRepository().updateUserProfile(user);
      _loggedInUser = user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
