import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastCustom {
  static toastError(String pesan) => Fluttertoast.showToast(
      msg: pesan,
      backgroundColor: const Color(0xFFD22027),
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM);
  static toastSuccess(String pesan) => Fluttertoast.showToast(
      msg: pesan,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM);

  static toastInfo(String pesan) => Fluttertoast.showToast(
      msg: pesan,
      backgroundColor: Colors.white.withOpacity(0.4),
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM);
}
