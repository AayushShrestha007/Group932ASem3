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

  Future<void> deleteConversation(String fromId, String toId) async {
    try {
      final query = await messageRef
          .where('fromId', isEqualTo: fromId)
          .where('toId', isEqualTo: toId)
          .get();

      final batch = FirebaseService.db.batch();
      for (final doc in query.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }



  Stream<QuerySnapshot<Map<String, dynamic>>> showMessages(String? fromId, String? toId){

    return FirebaseService.db.collection("messages").where("toID", whereIn:[toId, fromId]).snapshots();


  }




}