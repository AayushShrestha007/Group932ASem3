import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? image;
  String? about;
  String? name;
  String? createdAt;
  bool? isOnline;
  String? id;
  String? uid;
  String? email;
  String? password;
  String? pushToken;
  List<String>? myFriends;
  List<String>? myFavorite;

  UserModel({
    this.image,
    this.about,
    this.name,
    this.createdAt,
    this.isOnline,
    this.id,
    this.uid,
    this.email,
    this.password,
    this.pushToken,
    this.myFriends,
    this.myFavorite,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(

        image: json["image"],
        about: json["about"],
        name: json["name"],
        createdAt: json["created_at"],
        isOnline: json["is_online"],
        id: json["id"],
        uid: json["uid"],
        email: json["email"],
        password: json["password"],
        pushToken: json["push_token"],
        myFriends: json["myFriends"] == null ? [] : List<String>.from(json["myFriends"]!.map((x) => x)),
        myFavorite: json["myFavorite"] == null ? [] : List<String>.from(json["myFavorite"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        "image": image,
        "about": about,
        "name": name,
        "created_at": createdAt,
        "is_online": isOnline,
        "id": id,
        "uid": uid,
        "email": email,
        "password": password,
        "push_token": pushToken,
        "myFriends": myFriends == null ? [] : List<dynamic>.from(myFriends!.map((x) => x)),
        "myFavorite": myFavorite == null? [] : List<dynamic>.from(myFavorite!.map((x) => x)),
      };


  factory UserModel.fromFirebaseSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) {
    // dynamic my_friends;
    // if(json.data()!.containsKey("my_friends")){
    //   my_friends = MyFriends.fromJson(
    //       json["my_friends"]);
    // }
    print(json["myFriends"]);
    return UserModel(
      image: json["image"],
      about: json["about"],
      name: json["name"],
      createdAt: json["created_at"],
      isOnline: json["is_online"],
      id: json["id"],
      uid: json["uid"],
      email: json["email"],
      password: json["password"],
      pushToken: json["push_token"],
      myFriends: json["myFriends"] == null ? [] : List<String>.from(json["myFriends"]!.map((x) => x)),
      myFavorite: json["myFavorite"] == null ? [] : List<String>.from(json["myFavorite"]!.map((x) => x)),
    );
  }
}



class MyFriends {
  String? id;

  MyFriends({
    this.id,
  });

  factory MyFriends.fromJson(Map<String, dynamic> json) => MyFriends(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class MyFavorite {
  String? id;

  MyFavorite({
    this.id,
  });

  factory MyFavorite.fromJson(Map<String, dynamic> json) => MyFavorite(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}