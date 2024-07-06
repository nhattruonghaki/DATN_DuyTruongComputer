import 'package:do_an_tot_nghiep/ViewModels/FB_AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dang_Ky_Admin extends StatefulWidget {
  const Dang_Ky_Admin({super.key});

  @override
  State<Dang_Ky_Admin> createState() => _Dang_Ky_AdminState();
}

class _Dang_Ky_AdminState extends State<Dang_Ky_Admin> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _dkTaiKhoanEmail = TextEditingController();
  final TextEditingController _dkMatKhau = TextEditingController();
  final TextEditingController _nhapLaiMatKhau = TextEditingController();
  String? _selectedRole = 'admin';
  @override
  void dispose() {
    _dkTaiKhoanEmail.dispose();
    _dkMatKhau.dispose();
    _nhapLaiMatKhau.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w.+-]{5,}@[^@]+\.[^@]+$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');
    return regex.hasMatch(password);
  }

  void _dangKyTK() async {
    String email = _dkTaiKhoanEmail.text;
    String mk = _dkMatKhau.text;
    String nlmk = _nhapLaiMatKhau.text;
    User? user =
        await _auth.signUpWithEmailAndPassword(email, mk, _selectedRole);

    if (mk != nlmk) {
      _showErrorDialog("Mật khẩu không khớp");
      return;
    }

    if (!isValidEmail(email)) {
      _showErrorDialog("Email không hợp lệ");
      return;
    }

    if (!isValidPassword(mk)) {
      _showErrorDialog(
          "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ thường, chữ hoa, số và ký tự đặc biệt");
      return;
    }

    if (user != null) {
      print('Tạo tài khoản thành công');
      Navigator.pushNamed(context, '/Trang_Chu');
    } else {
      _showErrorDialog("Tạo tài khoản thất bại. Vui lòng thử lại.");
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
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      TextField(
                        controller: _dkTaiKhoanEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                        child: DropdownButton<String>(
                          value: _selectedRole,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRole = newValue;
                            });
                          },
                          items: const [
                            DropdownMenuItem<String>(
                              child: Text('admin'),
                              value: 'admin',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('nhanvien'),
                              value: 'nhanvien',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('kinhdoanh'),
                              value: 'kinhdoanh',
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () {
                            _dangKyTK();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white),
                          child: Text('Đăng ký')),
                    ]))
          ],
        ),
      ),
    );
  }
}
