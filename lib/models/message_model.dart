// To parse this JSON data, d
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String? fromId;
  String? msg;
  String? read;
  String? sent;
  String? toId;
  String? type;


  MessageModel({
    this.fromId,
    this.msg,
    this.read,
    this.sent,
    this.toId,
    this.type,

  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    fromId: json["fromID"].toString(),
    msg: json["msg"].toString(),
    read: json["read"].toString(),
    sent: json["sent"].toString(),
    toId: json["toID"].toString(),
    type: json["type"].toString(),

        // == Type.image.name ? Type.image: Type.text,
  );

  Map<String, dynamic> toJson() => {
    "fromID": fromId,
    "msg": msg,
    "read": read,
    "sent": sent,
    "toID": toId,
    "type": type,

  };

  factory MessageModel.fromFirebaseSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) {

    return MessageModel(
      fromId: json["fromID"].toString(),
      msg: json["msg"].toString(),
      read: json["read"].toString(),
      sent: json["sent"].toString(),
      toId: json["toID"].toString(),
      type: json["type"].toString(),

          // == Type.image.name ? Type.image: Type.text,
    );
  }

}
// enum Type {text, image, audio, file}
