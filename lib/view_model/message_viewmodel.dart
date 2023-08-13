import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/repositories/message_repositories.dart';
import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class MessageViewModel with ChangeNotifier{

  Stream<QuerySnapshot<Map<String, dynamic>>>? _messages;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get messages=> _messages;


  String? _lastFromMessage;
  get lastFromMessage=> _lastFromMessage;




  Future<void> sendMessage(String msg, String fromId, String toId) async{
    try{
      await MessageRepository().sendMessage(msg, fromId, toId);

    } catch(e){
      rethrow;
    }
  }

  Map<String, String> _lastMessages = {};
  Map<String, String> get lastMessages =>_lastMessages;

  Future<void> showMessages(String? fromId, String? toId)async {
    try{

      _messages = await MessageRepository().showMessages(fromId, toId);
      print("messages" + _messages.toString());
      // _messages?.forEach((element) async {
      //   final response = await MessageRepository().showLastFromMessage(fromId, toId);
      //   print("ersponse" +response.toString());
      // });
      notifyListeners();

    }catch(e){
      rethrow;

    }
  }

  Future<void> deleteMessage(String? fromId, String? toId) async{
    try{
      await MessageRepository().deleteMessage(fromId, toId);
      _messages = await MessageRepository().showMessages(fromId, toId);
      notifyListeners();

    }catch(err){
      rethrow;
    }
  }

  Future<void> showLastFromMessage(String? fromId, String? toId)async {
    try{
      _lastFromMessage = await MessageRepository().showLastFromMessage(fromId, toId);
      notifyListeners();

    }catch(e){
      rethrow;

    }
  }








}