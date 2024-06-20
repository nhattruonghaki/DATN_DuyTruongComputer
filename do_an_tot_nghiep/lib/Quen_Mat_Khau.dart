import 'package:flutter/material.dart';

class Quen_MK extends StatelessWidget {
  Quen_MK({super.key});
  final TextEditingController _email = TextEditingController();

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
              onPressed: (){
                Navigator.popUntil(context, (route) => route.isCurrent);
                  Navigator.pushNamed(context, '/Doi_Mat_Khau');
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