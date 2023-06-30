import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_viewmodel.dart';
import '../../view_model/global_ui_viewmodel.dart';


class ValidateLogin{
  static String? emailValidate(String? value){
    if(value==null || value.isEmpty){
      return "Email is required";
    }
    return null;
  }

  static String? passwordValidate(String? value){
    if(value==null || value.isEmpty){
      return "Password is required";
    }
    return null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscureTextPassword= true;

  TextEditingController _emailController= TextEditingController(
    text: "test@gmail.com"
  );
  TextEditingController _passwordController= TextEditingController(
    text: "123456"
  );


  final _formKey= GlobalKey<FormState>();

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;


  void login() async{
    if (_formKey.currentState == null){
      return;
    }

    _ui.loadState(true);

    try{
      await _authViewModel.login(_emailController.text, _passwordController.text)
          .then((value){
        Navigator.of(context).pushNamed('/userselect');
      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    } catch (err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);

  }

  void initState(){
    _ui= Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel= Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Login'),
        // ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            ),
            Positioned(
              top: -200,
              right: -145,
              child: Container(
                height: 690,
                width: 650,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2977F6),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 5,
              right: 20,
              child: Image.asset(
                'assets/images/Login.png',
                height: 150,
                width: 150,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 200.0, bottom: 16.0),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: ValidateLogin.emailValidate,
                      keyboardType: TextInputType.emailAddress ,
                      controller: _emailController,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Color(0xFF88ADEA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(

                      validator: ValidateLogin.passwordValidate,
                      controller: _passwordController,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Color(0xFF88ADEA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),

                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureTextPassword = !_obscureTextPassword;});
                          },
                          child: Icon(_obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                            size: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5), // Reduced the gap here
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          // Add your forgot password action here
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                          login();

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2086B1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF35809F),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed("/register");
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
