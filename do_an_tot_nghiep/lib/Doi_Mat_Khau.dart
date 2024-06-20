import 'package:flutter/material.dart';

class Doi_Mat_Khau extends StatelessWidget {
  Doi_Mat_Khau({super.key});
  final TextEditingController _matKhauMoi = TextEditingController();
  final TextEditingController _nhapLaiMKoi = TextEditingController();

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
                    Padding(padding: EdgeInsets.all(20)),
                    Text('Đổi mật khẩu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  Padding(padding: EdgeInsets.all(16.0)),
                  
                    TextField(
                    controller: _matKhauMoi,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu mới',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),

                  TextField(
                    controller: _nhapLaiMKoi,
                    decoration: const InputDecoration(
                      labelText: 'Nhập lại mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),

                  ElevatedButton(
                    onPressed: (){
                    
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white
                    ),
                    child: Text('OK')),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}