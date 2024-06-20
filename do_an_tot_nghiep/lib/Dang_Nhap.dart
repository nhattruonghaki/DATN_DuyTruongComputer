import 'package:flutter/material.dart';

class Dang_Nhap extends StatelessWidget {
  Dang_Nhap({super.key});
  final TextEditingController _tenTaiKhoan = TextEditingController();
  final TextEditingController _matKhau = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(20.0)),
            Text('Đăng nhập',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
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
              onPressed: (){
                String TK = _tenTaiKhoan.text;
                String MK = _matKhau.text;

                if(TK == 'admin' && MK == "12345"){
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Thành công'),
                        content: Text('Đăng nhập thành công!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushNamed(context, '/Trang_Chu');
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    });
                }
                else{
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Thất bại'),
                        content: Text('Tên tài khoản hoặc mật khẩu không đúng!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              child: Text('Đăng nhập')),
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isCurrent);
                  Navigator.pushNamed(context, '/Dang_Ky');
                },
                child: Text('Bạn chưa có tài khoản? Đăng ký tại đây', 
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400
                  ),),
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
                child: Text('Quên mật khẩu?', 
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400
                  ),),
                ),
                ),
              )
          ]),),
      ),
    );
  }
}