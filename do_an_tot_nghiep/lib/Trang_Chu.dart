import 'package:flutter/material.dart';

class Trang_Chu extends StatelessWidget {
  Trang_Chu({super.key});
  final TextEditingController _timKiem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text('DuyTruong Máy in & Mực in',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),

        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isCurrent);
                  Navigator.pushNamed(context, '/Gio_Hang');
            },
          ),
        ],

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Mở drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            //   child: Text(
            //     'Menu',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Đóng drawer
                // Xử lý khi người dùng chọn Home
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Đóng drawer
                // Xử lý khi người dùng chọn Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context); // Đóng drawer
                // Xử lý khi người dùng chọn About
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(5.0)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _timKiem,
              decoration: InputDecoration(
                hintText: 'Nhập tên, mã sản phẩm',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}