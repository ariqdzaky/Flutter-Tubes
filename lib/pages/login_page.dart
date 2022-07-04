
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/auth_log_page.dart';
import 'package:tubes/pages/login_screen_page.dart';
import 'package:tubes/widgets/appHeader.dart';
import 'package:tubes/widgets/appText.dart';
import 'package:tubes/Provider/googleSignIn.dart';
import 'package:tubes/widgets/loginPageButton.dart';
import 'package:tubes/widgets/responsiveButton.dart';
import 'package:tubes/pages/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: Color.fromARGB(240, 98,189,175),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    /*
                    Container(
                      padding: EdgeInsets.only(bottom: 0.3),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        )),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                    */
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        //color: Color.fromARGB(240, 98,189,175),
                        image: DecorationImage(
                          alignment: Alignment(0.0,
                              0.0), //Alignment(0.0, 0.5) == FractionalOffset(0.0, 0.7)
                          image: AssetImage(
                            'assets/component/photo1.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 15,
                            ),
                            //  child: GestureDetector(
                            //    onTap: () {
                            //      Navigator.push(
                            //        context,
                            //        MaterialPageRoute(
                            //          builder: (context) => Home(),
                            //        )
                            //      );
                            //    },
                            //    child: const Text(
                            //      "Skip",
                            //      style: TextStyle(
                            //        fontFamily: "Inter",
                            //        color: Color.fromARGB(190, 46, 46, 46),
                            //        decoration: TextDecoration.underline,
                            //        fontWeight: FontWeight.w700,
                            //        letterSpacing: 0.7
                            //      ),
                            //    ),
                            // ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height / 3) -
                          MediaQuery.of(context).viewPadding.top,
                      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      //margin: EdgeInsets.only(top: 70),
                      child: Column(
                        children: [
                          SizedBox(
                            //height: MediaQuery.of(context).size.height / 3,
                            //width: MediaQuery.of(context).size.width - 40,
                            child: appHeader(
                              text:
                                  "Login untuk mendapatkan pengalaman tour yang lebih baik.",
                              size: 28,
                              //color: Color.fromARGB(240, 98,189,175),
                              color: Color.fromARGB(240, 0, 0, 0),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 255, 255, 255),
                                    onPrimary: Color.fromARGB(245, 0, 0, 0),
                                    minimumSize: Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    side: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(245, 0, 0, 0)),
                                    shadowColor: Color.fromARGB(0, 0, 0, 0),
                                  ),
                                  onPressed: () {
                                    final provider =
                                        Provider.of<GoogleSingInProvider>(
                                            context,
                                            listen: false);
                                    provider.googleLogin();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AuthLog(),
                                        ));
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.google,
                                  ), //color: Color.fromARGB(240, 62,185,166),
                                  label:
                                      const Text("Masuk menggunakan Google")),
                              //LoginPageButton(text: "Masuk menggunakan Google", needImg: 0,),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    onPrimary:
                                        const Color.fromARGB(245, 0, 0, 0),
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(245, 0, 0, 0)),
                                    shadowColor:
                                        const Color.fromARGB(0, 0, 0, 0),
                                  ),
                                  onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreenPage(),
                                    )
                                  );
                                },
                                  icon: const FaIcon(FontAwesomeIcons.envelope),
                                  label: const Text("Masuk menggunakan Email")),
                              //LoginPageButton(text: "Masuk menggunakan Email", needImg: 1,),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
