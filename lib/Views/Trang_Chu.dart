import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tot_nghiep/Models/Item_sp.dart';
import 'package:do_an_tot_nghiep/Views/Chi_Tiet_SP.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TrangChuCustomer extends StatefulWidget {
  const TrangChuCustomer({super.key});

  @override
  State<TrangChuCustomer> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChuCustomer> {
  final TextEditingController _timKiem = TextEditingController();

  Future<List<Map<String, dynamic>>> getProductsByCategory(String loaiSP) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('quan_ly_kho')
        .where('loaiSP', isEqualTo: loaiSP)
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  String chuyenDoiDangTien(int giaTien) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0).format(giaTien);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          'DuyTruong Computer',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 15, 
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
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
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
                         title: const Text('Đăng xuất'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14.0, 10.0, 10.0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                        child: TextField(
                          controller: _timKiem,
                          decoration: InputDecoration(
                            hintText: 'Nhập tên, mã sản phẩm',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, 
                              horizontal: 12
                            ),
                            isDense: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                String searchQuery = _timKiem.text.trim();
                                Navigator.pushNamed(
                                  context,
                                  '/Tim_Kiem',
                                  arguments: {'searchQuery': searchQuery},
                                );
                              },
                            ),
                          ),
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                    child: DropdownButton<String>(
                      value: 'Tất cả',
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue == 'Tất cả') {
                          Navigator.pushNamed(context, '/Trang_Chu');
                        } else {
                          Navigator.pushNamed(context, '/Loai_SP', arguments: {'loaiSP': newValue});
                        }
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          child: Text('Tất cả'),
                          value: 'Tất cả',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('Máy in'),
                          value: 'Máy in',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('Laptop'),
                          value: 'Laptop',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              child: CarouselSlider(
                items: [
                  'assets/img/ha1.jpg',
                  'assets/img/ha2.jpg',
                  'assets/img/ha3.jpg',
                ].map((imagePath) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 230,
                ),
              ),
            ),
            // Máy in và mực in
            buildProductSection('Máy in'),
            SizedBox(height: 10),
            buildProductSection('Laptop'),
          ],
        ),
      ),
    );
  }

  Widget buildProductSection(String category) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getProductsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có sản phẩm nào'));
        } else {
          final products = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: products.map((product) => buildProductCard(product)).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChiTietSp(
              item: ItemSp(
                tensp: product['tenSP'],
                masp: product['maSP'],
                hinhanh: product['hinhAnhUrl'],
                loaisp: product['loaiSP'],
                gia: product['giaTien'],
                sl: product['soLuong'],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product['hinhAnhUrl'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              product['tenSP'] ?? 'Tên sản phẩm',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              chuyenDoiDangTien(product['giaTien']),
              style: TextStyle(color: Colors.red),
            ),
            Row(
              children: [
                Text(
                  'Tình trạng: ',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Icon(
                  product['soLuong'] > 0 ? Icons.check_circle : Icons.cancel,
                  color: product['soLuong'] > 0 ? Colors.green : Colors.red,
                  size: 16,
                ),
                Text(
                  product['soLuong'] > 0 ? 'Còn hàng' : 'Hết hàng',
                  style: TextStyle(
                    color: product['soLuong'] > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}