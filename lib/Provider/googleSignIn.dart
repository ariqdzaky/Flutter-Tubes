import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:tubes/model/toast.dart';
import 'package:tubes/pages/homescreen.dart';

class GoogleSingInProvider extends ChangeNotifier {
  final googleSingIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSingIn.signIn();

      if (googleUser == null) return;

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("ini credential $credential");
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future googleLogOut() async {
    await googleSingIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<void> addWisata(BuildContext context, String nama, String address,
      String deskripsi, String image, String lat, String long) async {
    CollectionReference wisata = firestore.collection('wisata');
    String docName = DateTime.now().microsecondsSinceEpoch.toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    //check name not same
    wisata.where('nama', isEqualTo: nama).get().then((value) {
      if (value.docs.length == 0) {
        wisata.doc(docName).set({
          'uid': DateTime.now().microsecondsSinceEpoch,
          'nama': nama,
          'alamat': address,
          'deskripsi': deskripsi,
          'image': image,
          'lat': lat,
          'long': long,
          'createdAt': DateTime.now().toString(),
          'updatedAt': DateTime.now().toString(),
        }).then((value) {
          ToastCustom.toastSuccess('Berhasil menambahkan wisata');
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
        }).catchError((error) => print("tidak berhasil: $error"));
      } else {
        ToastCustom.toastError("Wisata sudah ada");
      }
    });
  }

  Future<void> editWisata(
      BuildContext context,
      String uid,
      String nama,
      String address,
      String deskripsi,
      String image,
      String lat,
      String long) async {
    CollectionReference wisata = firestore.collection('wisata');
    print(uid);
    if (image.isEmpty) {
      wisata.doc(uid).update({
        'nama': nama,
        'alamat': address,
        'deskripsi': deskripsi,
        'lat': lat,
        'long': long,
        'updatedAt': DateTime.now().toString(),
      }).then((value) {
        ToastCustom.toastSuccess('Berhasil mengubah wisata');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
      }).catchError((error) => print("tidak berhasil: $error"));
      // print('wisata berhasil ditambah');
    } else {
      wisata.doc(uid).update({
        'nama': nama,
        'alamat': address,
        'deskripsi': deskripsi,
        'image': image,
        'lat': lat,
        'long': long,
        'updatedAt': DateTime.now().toString(),
      }).then((value) {
        ToastCustom.toastSuccess('Berhasil mengubah wisata');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
      }).catchError((error) => print("tidak berhasil: $error"));
      // print('wisata berhasil ditambah');
    }
  }
}
