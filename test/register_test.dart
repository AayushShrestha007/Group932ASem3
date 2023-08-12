import 'package:ez_text/firebase_options.dart';
import 'package:ez_text/models/user_model.dart';
import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:ez_text/screens/auth/register_screen.dart';
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





void main(){


  test("empty email test",(){
    String? result = ValidateRegister.emailValidate("");
    expect(result, "Email is required");
  });

  test("empty name test",(){
    String? result = ValidateRegister.nameValidate("");
    expect(result, "name is required");
  });
  test("empty password test",(){
    String? result = ValidateRegister.passwordValidate("");
    expect(result, "password is required");
  });


}