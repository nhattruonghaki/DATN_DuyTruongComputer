import 'package:do_an_tot_nghiep/ViewModels/FB_AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dang_Nhap extends StatefulWidget {
  const Dang_Nhap({super.key});

  @override
  State<Dang_Nhap> createState() => _Dang_NhapState();
}

class _Dang_NhapState extends State<Dang_Nhap> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _tenTaiKhoan = TextEditingController();
  final TextEditingController _matKhau = TextEditingController();
  @override
  void dispose() {
    _tenTaiKhoan.dispose();
    _matKhau.dispose();
    super.dispose();
  }

  void _dangNhapTK() async {
    String email = _tenTaiKhoan.text;
    String mk = _matKhau.text;
    User? user = await _auth.signInWithEmailAndPassword(email, mk);
   
   if (user != null) {
      print('Đăng nhập hành công');
      String? role = await _auth.getUserRole(user.uid);
      if (role == 'admin') {
        Navigator.pushNamed(context, '/Dang_Ky_Admin');
      } else if (role == 'kinhdoanh') {
        Navigator.pushNamed(context, '/Thong_Ke');
      } else if (role == 'nhanvien') {
        Navigator.pushNamed(context, '/Quan_Ly_Kho');
      } else {
        Navigator.pushNamed(context, '/Trang_Chu');
      }
    } else {
      _showErrorDialog("Đăng nhập thất bại. Vui lòng thử lại.");
    }
  
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(padding: EdgeInsets.all(20.0)),
            Text(
              'Đăng nhập',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            TextField(
              controller: _tenTaiKhoan,
              decoration: const InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _matKhau,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  _dangNhapTK();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: Text('Đăng nhập')),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isCurrent);
                Navigator.pushNamed(context, '/Dang_Ky');
              },
              child: Text(
                'Bạn chưa có tài khoản? Đăng ký tại đây',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isCurrent);
                    Navigator.pushNamed(context, '/Quen_MK');
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
