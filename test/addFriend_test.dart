import 'package:ez_text/firebase_options.dart';
import 'package:ez_text/models/user_model.dart';
import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:ez_text/screens/home/home_screen.dart';
import 'package:ez_text/view_model/auth_viewmodel.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockRepos/mockAuthRepo.dart';



class AddFriendsTest extends Mock  implements AuthRepository{}

@GenerateMocks([AddFriendsTest])
Future<void> main() async {

  late MockAuthRepo mockRepo;

  setUp(() {
    mockRepo= MockAuthRepo();
  });

  test(
    "testing if correct user is found with the provided email or not", () async{
      final model = UserModel();
      
      when(mockRepo.getUserDetailWithEmail("test3@gmail.com")).thenAnswer((_) async{
        return model;
      });
      final res= await mockRepo.getUserDetailWithEmail("test3@gmail.com");
      expect(res, isA<UserModel>());
      expect(res,model);

  });

  test("test to see if exception is thrown or not", (){
    when(mockRepo.getUserDetailWithEmail("test3@gmail.com")).thenAnswer((_) async{
      throw Exception();
    });
    final res= mockRepo.getUserDetailWithEmail("test3@gmail.com");
    expect(res, throwsException);

  });

  test("empty email test",(){
    String? result = ValidateFriendAdd.notNullValidation("");
    expect(result, "Email is required");
  });

}