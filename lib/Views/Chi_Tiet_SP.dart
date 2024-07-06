import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tot_nghiep/Models/Item_sp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ChiTietSp extends StatelessWidget {
  final ItemSp item;

  const ChiTietSp({
    Key? key,
    required this.item,
  }) : super(key: key);

  Future<Map<String, dynamic>?> getProductByCode(String code) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('quan_ly_kho')
        .where('maSP', isEqualTo: code)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    }
    return null;
  }

  String chuyenDoiDangTien(int giaTien) {
    final formatCurrency = NumberFormat.currency(
        locale: 'vi_VN', symbol: ' VND', decimalDigits: 0);
    return formatCurrency.format(giaTien);
  }

  void _showDialog_MuaNgay(BuildContext context, Map<String, dynamic> product) {
    int soLuong = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận mua hàng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tên sản phẩm: ${product['tenSP']}'),
              Text('Giá tiền: ${chuyenDoiDangTien(product['giaTien'])}'),
              Text('Số lượng: $soLuong'),
              //Text('Mã sản phẩm: ${product['maSP']}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                  context,
                  '/Dat_Hang',
                  arguments: {
                    'giaTien': product['giaTien'],
                    'soLuong': soLuong,
                    'maSP': product['maSP'],
                  },
                );
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
        title: Text(
          'DuyTruong Computer',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getProductByCode(item.masp),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      product['hinhAnhUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    product['tenSP'] ?? 'Tên sản phẩm',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Giá tiền: ',
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 15.0),
                      ),
                      Spacer(),
                      Text(
                        chuyenDoiDangTien(product['giaTien']),
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Text(
                        'Giá khuyến mãi: ',
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 15.0),
                      ),
                      Spacer(),
                      Text(
                        '${product['discountedPrice'] ?? 'Giá khuyến mãi'} VND',
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Text(
                        'Tình trạng: ',
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 15.0),
                      ),
                      Icon(
                        product['soLuong'] > 0
                            ? Icons.check_circle
                            : Icons.cancel,
                        color:
                            product['soLuong'] > 0 ? Colors.green : Colors.red,
                        size: 18.0,
                      ),
                      Text(
                        product['soLuong'] > 0 ? ' Còn hàng' : ' Hết hàng',
                        style: TextStyle(
                          color: product['soLuong'] > 0
                              ? Colors.green
                              : Colors.red,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showDialog_MuaNgay(context, product);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Mua Ngay',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isCurrent);
                        Navigator.pushNamed(context, '/Gio_Hang');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Thêm vào giỏ hàng',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
