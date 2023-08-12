import 'dart:math';

import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:ez_text/screens/auth/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('empty email test', () {
    // AuthRepository authRepository = new AuthRepository();
    String? result= ValidateLogin.emailValidate("");
    expect(result, "Email is required");
  });

  test('empty password test', (){
    String? result = ValidateLogin.passwordValidate("");
    expect(result, "Password is required");

  });
}