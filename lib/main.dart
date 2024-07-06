import 'package:do_an_tot_nghiep/Views/Dang_Ky.dart';
import 'package:do_an_tot_nghiep/Views/Dang_Nhap.dart';
import 'package:do_an_tot_nghiep/Views/Dat_Hang.dart';
import 'package:do_an_tot_nghiep/Views/Doi_Mat_Khau.dart';
import 'package:do_an_tot_nghiep/Views/Gio_Hang.dart';
import 'package:do_an_tot_nghiep/Views/Loai_SP.dart';
import 'package:do_an_tot_nghiep/Views/Quen_Mat_Khau.dart';
import 'package:do_an_tot_nghiep/Views/Tim_Kiem.dart';
import 'package:do_an_tot_nghiep/Views/Trang_Admin/Dang_Ky_Admin.dart';
import 'package:do_an_tot_nghiep/Views/Trang_Chu.dart';
import 'package:flutter/material.dart';
import 'Views/Trang_Admin/Quan_Ly_Kho.dart';
import 'Views/Trang_Admin/Thong_Ke.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/Dang_Ky_NV': (context) => Dang_Ky_Admin(),
        '/': (context) => Dang_Nhap(),
        '/Dang_Ky': (context) => Dang_Ky(),
        '/Quen_MK': (context) => Quen_MK(),
        '/Doi_Mat_Khau': (context) => Doi_Mat_Khau(),
        '/Trang_Chu': (context) => TrangChuCustomer(),
        '/Gio_Hang': (context) => Gio_Hang(),
        '/Dat_Hang': (context) => Dat_Hang(),
        '/Tim_Kiem': (context) => Tim_Kiem(),
        '/Loai_SP': (context) => Loai_SP(
              loaiSP: ModalRoute.of(context)?.settings.arguments != null
                  ? (ModalRoute.of(context)!.settings.arguments
                          as Map<String, dynamic>)['loaiSP'] ??
                      ''
                  : '',
            ),
        '/Quan_Ly_Kho': (context) => Quan_Ly_Kho(),
        '/Thong_Ke': (context) => Thong_Ke(),
      },
    );
  }
}
