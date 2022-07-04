import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tubes/pages/auth_log_page.dart';
import 'package:tubes/widgets/appHeader.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  late String _email;
  late String _pass;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //key: _scaffoldKey,
        backgroundColor: const Color.fromARGB(240, 98, 189, 175),//Color.fromARGB(171, 58, 170, 153),
        elevation: 0,
        title: const Text(
          'Explore SUMUT',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 30, right: 30),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: appHeader(text: 'Masuk/Daftar'),
            ),
            SizedBox(height: 50),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email'
              ),
              onChanged: (value){
                setState(() {
                  _email = value.trim();
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              //keyboardType: TextInputType,
              decoration: const  InputDecoration(
                hintText: 'Password'
              ),
              onChanged: (value){
                setState(() {
                  _pass = value.trim();
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
                onPrimary: Color.fromARGB(245, 0, 0, 0),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                side: BorderSide(width: 1, color: Color.fromARGB(245, 0, 0, 0)),
                shadowColor: Color.fromARGB(0, 0, 0, 0),
              ),
              onPressed: () {
                try {
                  auth.signInWithEmailAndPassword(email: _email, password: _pass).whenComplete(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthLog(),
                      )
                    );
                  });
                } catch (e) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreenPage(),
                    )
                  );
                }
              }, 
              child: Text("Masuk")
            ),
            SizedBox(height: 5),
            const Text(
              'atau',
              style: TextStyle(
                color: Color.fromARGB(245, 97, 97, 97),
                fontSize: 14
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
                onPrimary: Color.fromARGB(245, 0, 0, 0),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                side: BorderSide(width: 1, color: Color.fromARGB(245, 0, 0, 0)),
                shadowColor: Color.fromARGB(0, 0, 0, 0),
              ),
              onPressed: () {
                try {
                  auth.createUserWithEmailAndPassword(email: _email, password: _pass).whenComplete(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreenPage(),
                      )
                    );
                  });
                } catch (e) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreenPage(),
                    )
                  );
                }
              }, 
              child: Text("Daftar")
            ),
          ],
        ),
      ),
    );
  }
}