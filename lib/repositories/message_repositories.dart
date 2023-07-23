import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/models/message_model.dart';

import '../services/firebase_service.dart';


class MessageRepository{



  CollectionReference<MessageModel> messageRef= FirebaseService.db.collection("messages")
      .withConverter<MessageModel>(
      fromFirestore:(snapshot, _){
        return MessageModel.fromFirebaseSnapshot(snapshot);
      },
      toFirestore:(model, _){
        return model.toJson();
      }
  );

  Future<void> sendMessage(String message, String Idfrom, String Idto ) async{
    try{
      final time= DateTime.now().millisecondsSinceEpoch.toString();

      await messageRef.doc(time).set(
          MessageModel(
            fromId: Idfrom,
            msg: message,
            read: "false",
            sent: time,
            toId: Idto,
            type: "Text Message",
          )
      );



    } catch(err){
      rethrow;
    }
  }

  Future<void> deleteMessage(String? fromId, String? toId) async {
    try{
      final response1 = await messageRef.where("fromID", isEqualTo: fromId).where("toID", isEqualTo: toId).get();
      final response2 = await messageRef.where("toID", isEqualTo: fromId).where("fromID", isEqualTo: toId).get();
      print("wassup");
      print(response1);
      // if(response1!=null){
      //   try{messageRef.doc(response1.docs.first.id).delete();} catch(err){
      //
      //   }
      // }
      // if(response2!=null){
      //   messageRef.doc(response2.docs.first.id).delete();
      // }

      try{messageRef.doc(response1.docs.first.id).delete();} catch(err){}
      try{messageRef.doc(response2.docs.first.id).delete();} catch(err){}

    }catch(err){
      rethrow;
    }


  }




  Stream<QuerySnapshot<Map<String, dynamic>>> showMessages(String? fromId, String? toId){

    return FirebaseService
        .db.collection("messages")
        .where("toID", whereIn:[toId, fromId])
        .snapshots();


  }




}