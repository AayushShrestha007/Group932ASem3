import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view_model/verify_viewmodel.dart';


class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final VerifyViewModel _viewModel = VerifyViewModel();
  final VerifyViewModel verifyViewModel = VerifyViewModel();
  FirebaseAuth get auth => auth;

  @override
  void initState() {
    super.initState();
    _viewModel.initializeFirebase();
    _viewModel.isEmailVerified =
        _viewModel.auth.currentUser?.emailVerified ?? false;
    if (!_viewModel.isEmailVerified &&
        !_viewModel.auth.currentUser!.providerData
            .any((userInfo) => userInfo.providerId == 'password')) {
      _viewModel.sendVerificationEmail();
      _viewModel.timer = Timer.periodic(
        Duration(seconds: 3),
            (_) => _viewModel.checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.deepOrangeAccent.shade100,
                    Colors.orange.shade300,
                    Colors.orange.shade200,
                    Colors.orange.shade100,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "EMAIL VERIFICATION",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 648,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "To verify your account:",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Please follow the given procedures.",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1. Press on the VERIFY button to verify.",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "2. The link would be sent to your Email.",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "3. Go to your Email to press it and verify.",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "*The link is a one-time link generated. "
                                    "\nAfter the completion of the above procedure, "
                                    "\nyou can log in to your UNISTAY ACCOUNT",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\t \t\t\tUNISTAY ACCOUNT",
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          Container(
                            width: double.infinity,
                            //
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side:
                                  BorderSide(color: Colors.orange.shade300),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20),
                              ),
                              onPressed: () {
                                verifyViewModel.sendVerificationEmail();
                                ;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "The verification link has already been sent to you! Check your mail!")));
                              },
                              child: Text(
                                "SEND VERIFICATION LINK",
                                style: TextStyle(fontSize: 20),
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
          ),
        ),
      ),
    );
  }
}
