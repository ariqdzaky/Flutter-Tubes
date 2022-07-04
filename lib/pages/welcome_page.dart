import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/login_page.dart';
import 'package:tubes/widgets/appHeader.dart';
import 'package:tubes/widgets/appText.dart';
import 'package:tubes/widgets/responsiveButton.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{
  final PageController _pageController = PageController();
  List images = [
    'index-0.png',
    'index-1.png',
    'index-2.png',
  ];
  
  List text = [
    "Selamat Datang!",
    "Pesiapkan untuk rencana untuk mengunjungi Sumatra Utara.",
    "Nikmati fitur yang membantu pengalaman berkunjung lebih baik."
  ];

  List colors = [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255)
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        controller: _pageController,
        itemBuilder: (_, index){
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: colors[index],
              image: DecorationImage(
                alignment: Alignment(0.0, 0.0),//Alignment(0.0, 0.5) == FractionalOffset(0.0, 0.7)
                image: AssetImage(
                  'assets/welcome-assets/'+images[index],
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 70,left: 20, right: 20),
              child: Column(
                children: <Widget> [
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        width: MediaQuery.of(context).size.width,
                        child: Container (
                          //margin: const EdgeInsets.only(top: 20,left: 20, right: 20),
                          child: appHeader(
                            text: text[index], 
                            size: index == 0?42:26, 
                            color: Color.fromARGB(230, 22, 22, 22),
                          )
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height - 300,),
                      //index==1?responsiveButton(text: "Lanjut",):SizedBox(height: 50,),
                      
                      //const SizedBox(height: 100,),
                      //appHeader(text: "Selamat Datang"),
                      //appText(text: "Selamat Datang", size: 30,),
                      /*
                      const SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child: appText(
                          text: "Aplikasi Explore Sumatra Utara merupakan aplikasi untuk membantu anda mengeksplore sumatra utara dengan lebih baik, dilengkapi dengan navigasi, gambar dan review dari beberapa sumber yang terpercaya",
                          color: const Color.fromARGB(170, 56, 56, 56),
                        ),
                      ),
                      */
                      //index==indexSlider?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: 
                        
                          List.generate(text.length, (indexSlider){
                            return Transform.scale(
                              scale: index==indexSlider? 1.3:1,
                              child:Container(
                                margin: const EdgeInsets.only(left: 8, right: 8),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: index==indexSlider?const Color.fromARGB(240, 62,185,166):const Color.fromARGB(240, 62,185,166).withOpacity(0.4),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 40,),
                        if (index == images.length -1) ...[
                          //responsiveButton(text: "Lanjut",),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                )
                              );
                            },
                            child: responsiveButton(
                              text: "Masuk",
                              colors: const Color.fromARGB(240, 62,185,166),
                              fontColor: const Color.fromARGB(255, 255, 255, 255),
                              width: 110,
                              fontSize: 19,
                              rounded: true,
                              radius: 50,
                            ),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              GestureDetector(
                                onTap: index > 0?previousPage:null,
                                child: responsiveButton(
                                  text: "",
                                  colors: index > 0?const Color.fromARGB(240, 62,185,166):const Color.fromARGB(80, 62,185,166),
                                  fontColor: index > 0? const Color.fromARGB(170, 255, 255, 255):const Color.fromARGB(80, 255, 255, 255),
                                  width: 50,
                                  fontSize: 17,
                                  rounded: true,
                                  radius: 50,
                                  icon: Icons.arrow_back_ios_rounded,
                                ),
                              ),
                              
                              SizedBox(width: MediaQuery.of(context).size.width - 140,),
                              GestureDetector(
                                onTap: index < images.length -1?nextPage:null,
                                child: responsiveButton(
                                  text: "",
                                  colors: index < images.length -1?const Color.fromARGB(240, 62,185,166):const Color.fromARGB(80, 62,185,166),
                                  fontColor: index < images.length -1? const Color.fromARGB(170, 255, 255, 255):const Color.fromARGB(80, 255, 255, 255),
                                  width: 50,
                                  fontSize: 17,
                                  rounded: true,
                                  radius: 50,
                                  icon: Icons.arrow_forward_ios_rounded,
                                ),
                              )
                              ,
                          ],
                        ),
                      ],
                    ],
                  ),
                  /*Column(
                    children: List.generate(text.length, (index){
                      return Container(
                        width: 8,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(240, 120,170,155),
                        ),
                      );
                    }),
                  )*/
                ],
              ),
            ),
          );
      }),
    );
  }

  void nextPage(){
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn
    );
  }

  void previousPage(){
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn
    );
  }
}