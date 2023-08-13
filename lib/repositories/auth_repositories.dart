import 'dart:developer' as developer;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_text/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';

class AuthRepository {
  CollectionReference<UserModel> userRef = FirebaseService.db
      .collection("users")
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) {
      return model.toJson();
    },
  );

  Future<UserCredential?> register(UserModel user) async {
    try {
      final response = await userRef.where("name", isEqualTo: user.name!).get();
      print("RESPONSE ${response}");
      UserCredential uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.uid = uc.user!.uid;

      await userRef.add(user).then(
            (DocumentReference doc) async {
          await userRef.doc(doc.id).update({
            "id": doc.id,
            "about": "",
          });
        },
      );
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print("wassup234");
      print(uc);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String uid) async {
    try {
      final response = await userRef.where("uid", isEqualTo: uid).get();
      var user = response.docs.single.data();
      user.pushToken = "";
      await userRef.doc(user.id).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetailWithEmail(String email) async {
    try {
      final response = await userRef.where("email", isEqualTo: email).get();
      var user = response.docs.single.data();
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetailWithId(String id) async {
    try {
      final response = await userRef.where("id", isEqualTo: id).get();
      var user = response.docs.single.data();
      print(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel?> addUser(
      UserModel model, String id, String email, UserModel loggedInUser) async {
    try {
      final response = await userRef.where("email", isEqualTo: email).get();

      userRef.doc(id).update({
        "myFriends": FieldValue.arrayUnion([response.docs.first.id]),
      });

      model.myFriends?.add(response.docs.first.id);

      // Update loggedInUser with the new friend
      loggedInUser.myFriends?.add(response.docs.first.id);

      return model;
    } catch (err) {
      print("REPO ERROR");
      rethrow;
    }
  }

  Future<UserModel?> addFavorite(UserModel model, String id, String email) async {
    try {
      final response = await userRef.where("email", isEqualTo: email).get();

      userRef.doc(id).update({
        "myFavorite": FieldValue.arrayUnion([response.docs.first.id]),
      });

      model.myFavorite?.add(response.docs.first.id);

      return model;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel?> removeFavorite(UserModel model, String id, String email) async {
    try {
      final response = await userRef.where("email", isEqualTo: email).get();

      userRef.doc(id).update({
        "myFavorite": FieldValue.arrayRemove([response.docs.first.id]),
      });

      model.myFavorite?.remove(response.docs.first.id);
      print(model.myFavorite);

      return model;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> removeFriend(String loggedIn, String friendId) async {
    try {
      await userRef.doc(loggedIn).update({
        "myFriends": FieldValue.arrayRemove([friendId]),
      });
      // final response = await userRef.doc(loggedIn).get();
      //
      // if (response!=null) {
      //   String userId = response.docs.first.id;
      //
      // }
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> changePassword(String password, String id) async {
    try {
      await FirebaseService.firebaseAuth.currentUser!
          .updatePassword(password);
      return true;
    } catch (err) {
      print("REPO ERR :: " + err.toString());
      rethrow;
    }
  }

  Future<String?> uploadProfileImage(File image, UserModel user) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePath = "profile_images/$imageName.jpg";
      TaskSnapshot snapshot = await FirebaseService
          .storageRef
          .child(imagePath)
          .putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (err) {
      print("REPO ERR :: " + err.toString());
      rethrow;
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      await userRef.doc(user.id).update(user.toJson());
    } catch (err) {
      print("REPO ERR :: " + err.toString());
      rethrow;
    }
  }
}
