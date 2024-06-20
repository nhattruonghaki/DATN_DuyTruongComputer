import 'package:flutter/material.dart';
import 'Dang_Nhap.dart';
import 'Dang_Ky.dart';
import 'Quen_Mat_Khau.dart';
import 'Doi_Mat_Khau.dart';
import 'Trang_Chu.dart';
import 'Gio_Hang.dart';
import 'Dat_Hang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => Dang_Nhap(),
        '/Dang_Ky':(context) => Dang_Ky(),
        '/Quen_MK':(context) => Quen_MK(),
        '/Doi_Mat_Khau':(context) => Doi_Mat_Khau(),
        '/Trang_Chu':(context) => Trang_Chu(),
        '/Gio_Hang':(context) => Gio_Hang(),
        '/Dat_Hang':(context) => Dat_Hang()
      },
    );
  }
}