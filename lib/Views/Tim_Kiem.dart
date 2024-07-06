import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tot_nghiep/Models/Item_sp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Chi_Tiet_SP.dart';

class Tim_Kiem extends StatefulWidget {
  const Tim_Kiem({super.key});

  @override
  State<Tim_Kiem> createState() => _Tim_KiemState();
}

class _Tim_KiemState extends State<Tim_Kiem> {
  late String searchQuery;
  late Future<List<Map<String, dynamic>>> searchResults;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    searchQuery = args['searchQuery'];
    searchResults = searchProducts(searchQuery);
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('quan_ly_kho')
        .get();
    final allProducts = querySnapshot.docs.map((doc) => doc.data()).toList();
    // Lọc sản phẩm chứa từ khóa trong tên sản phẩm
    final results = allProducts.where((product) {
      final tenSP = product['tenSP'] as String;
      return tenSP.toLowerCase().contains(query.toLowerCase());
    }).toList();
    print("Found ${results.length} results");
    for (var product in results) {
      print("Product: ${product['tenSP']}, Price: ${product['giaTien']}");
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Kết quả tìm kiếm',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 15, 
            color: Colors.white),),
            iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không tìm thấy sản phẩm nào'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: product['hinhAnhUrl'] != null 
                    ? Image.network(
                        product['hinhAnhUrl'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image),
                  title: Text(product['tenSP']),
                  subtitle: Text(chuyenDoiDangTien(product['giaTien'])),
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
                );
              },
            );
          }
        },
      ),
    );
  }

  String chuyenDoiDangTien(int giaTien) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0).format(giaTien);
  }
}