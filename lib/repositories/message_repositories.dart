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



  Stream<QuerySnapshot<Map<String, dynamic>>> showMessages(String? fromId, String? toId){

    return FirebaseService.db.collection("messages").where("toID", whereIn:[toId, fromId]).snapshots();
    // return FirebaseService.db.collection("messages").where(Filter.or(
    //     Filter("toId", isEqualTo: "kim"),
    //     Filter("sender_name", isEqualTo: "kim")
    // )).snapshots();


  }

  Future<String?> showLastFromMessage(String? fromId, String? toId) async{
    final response = await  messageRef.where("fromID", isEqualTo: fromId).where("toID", isEqualTo: toId).get();
    // final response = await  messageRef.where("toID", whereIn:[toId, fromId]).get();
    print("MESSAGE SENT :: "+response.toString());
    var message= response.docs.last.data();
    print("MESSAGE SENT :: "+message.msg.toString());
    return message.msg.toString();

  }


}