import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// CHƯA SỬ DỤNG ĐƯỢC, PHẢI RÀN BUỘC SAO CHO NGƯỜI DÙNG NHẬP PHẢI ĐÚNG EAMIL CÓ TRONG FDIREBASE 
class Quen_MK extends StatelessWidget {
  Quen_MK({super.key});
  final TextEditingController _email = TextEditingController();

Future <void> sendPassResetEmail(String email)async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Đã gửi email đặt lại mật khẩu');
  }catch (e){
    print('Gửi email đặt lại mật khẩu thất bại');
  }
}

  Future<bool> isEmailRegistered(String email) async {
    try {
      List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      print('Kiểm tra email thất bại: $e');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quên mật khẩu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            Padding(padding: EdgeInsets.all(16.0)),

              TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async{
                 String email = _email.text.trim();
                bool isRegistered = await isEmailRegistered(email);
                if (isRegistered) {
                  await sendPassResetEmail(email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã gửi email đặt lại mật khẩu'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email này chưa được đăng ký'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              child: Text('Gửi')),
            ],
          ),
        ),
          ],
        )
    );
  }
}