import 'package:ez_text/models/user_model.dart';
import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:ez_text/screens/home/home_screen.dart';
import 'package:ez_text/view_model/auth_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test("empty email test",(){
    String? result = ValidateFriendAdd.notNullValidation("");
    expect(result, "Email is required");
});

}