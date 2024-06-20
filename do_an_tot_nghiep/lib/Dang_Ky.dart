import 'package:flutter/material.dart';

class Dang_Ky extends StatelessWidget {
  Dang_Ky({super.key});
  final TextEditingController _dkHoTen = TextEditingController();
  final TextEditingController _dkTaiKhoan = TextEditingController();
  final TextEditingController _dkMatKhau = TextEditingController();
  final TextEditingController _dkEmail = TextEditingController();
  final TextEditingController _nhapLaiMatKhau = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Đăng ký',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            Padding(padding: EdgeInsets.all(10.0)),
            TextField(
              controller: _dkHoTen,
              decoration: const InputDecoration(
                labelText: 'Họ và tên',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            TextField(
              controller: _dkTaiKhoan,
              decoration: const InputDecoration(
                labelText: 'Tên tài khoản',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            TextField(
              controller: _dkMatKhau,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            TextField(
              controller: _nhapLaiMatKhau,
              decoration: const InputDecoration(
                labelText: 'Nhập lại mật khẩu',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            TextField(
              controller: _dkEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: (){
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              child: Text('Đăng ký')),
          ]
        )
      )
        ],
      ),
      ),
    );
  }
}