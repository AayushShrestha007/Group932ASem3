import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/models/message_model.dart';

import '../services/firebase_service.dart';

enum Type {text, image, audio, file}

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
      // await messageRef.add(
      //   MessageModel(
      //     fromId: Idfrom,
      //     msg: message,
      //     read: "false",
      //     sent: time,
      //     toId: Idto,
      //     type: "Text Message",
      //   )
      // );

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



  Stream<QuerySnapshot<MessageModel>> showAllMessages(){
    return messageRef.snapshots();
  }


}