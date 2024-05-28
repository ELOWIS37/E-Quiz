import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/LoginPage.dart';
import 'package:quiz_app/QuizHomePage.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return QuizHomePage();
    } else {
      return LoginPage();
    }
  }
}