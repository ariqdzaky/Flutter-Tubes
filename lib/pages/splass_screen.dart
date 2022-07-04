import 'package:flutter/material.dart';
import 'package:tubes/pages/detail_tempat_wisata.dart';

class SplassScreen extends StatefulWidget {
  const SplassScreen({Key? key}) : super(key: key);

  @override
  _SplassScreenState createState() => _SplassScreenState();
}

class _SplassScreenState extends State<SplassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Wisata SUMUT'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/image/logo.png",
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Travel App",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Lovely",
                        color: Colors.black),
                  ),
                  ElevatedButton(
                      child: const Text('open route'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailTempatWisataScreen(
                                    alamat: 'sumatera utara',
                                    deskripsi:
                                        'Parapat merupakan kota di tepi Danau Toba yang memiliki beberapa tempat wisata yang memukau',
                                    id: '',
                                    lat: 0,
                                    docname: '',
                                    long: 0,
                                    nama: '',
                                    imageSrc: "",
                                    gambarLoc: "",
                                  )),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
