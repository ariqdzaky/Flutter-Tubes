import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tubes/pages/homescreen.dart';
import 'package:tubes/pages/login_page.dart';
import 'package:tubes/pages/welcome_page.dart';

class AuthLog extends StatelessWidget {
  const AuthLog({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Home();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Terjadi Kesalahan.'));
          } else if (snapshot.data == null) {
            return const WelcomePage();
          } else {
            return const LoginPage();
          }
          //return SignUpWidget();
        },
      ),
    );
  }
}
