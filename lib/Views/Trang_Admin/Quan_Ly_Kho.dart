import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Quan_Ly_Kho extends StatefulWidget {
  const Quan_Ly_Kho({super.key});

  @override
  State<Quan_Ly_Kho> createState() => _Quan_Ly_KhoState();
}

class _Quan_Ly_KhoState extends State<Quan_Ly_Kho> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController maSanPhamController = TextEditingController();
  TextEditingController tenSanPhamController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController giaTienController = TextEditingController();
  String? _hinhAnhUrl;

  final ImagePicker _hinhAnhPicker = ImagePicker();
  File? _hinhAnh;

  Future<void> _pickHinhAnh() async {
    final pickedFile = await _hinhAnhPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _hinhAnh = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadHinhAnh(String productId) async {
    if (_hinhAnh == null) return;
    try {
      final storageRef = _storage.ref().child('$productId.jpg');
      await storageRef.putFile(_hinhAnh!);
      _hinhAnhUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print('Upload thất bại: $e');
    }
  }

  void _themSanPham() {
    TextEditingController maSanPhamController = TextEditingController();
    TextEditingController tenSanPhamController = TextEditingController();
    TextEditingController soLuongController = TextEditingController();
    TextEditingController giaTienController = TextEditingController();
    String luaChonSanPham = 'Máy in';

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Thêm sản phẩm'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: maSanPhamController,
                  decoration: InputDecoration(labelText: 'Mã sản phẩm'),
                ),
                TextField(
                  controller: tenSanPhamController,
                  decoration: InputDecoration(labelText: 'Tên sản phẩm'),
                ),
                TextField(
                  controller: soLuongController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Số lượng'),
                ),
                TextField(
                  controller: giaTienController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Giá tiền'),
                ),
                DropdownButton<String>(
                  value: luaChonSanPham,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        luaChonSanPham = newValue;
                      });
                    }
                  },
                  items: <String>['Máy in', 'Hộp mực', 'Webcam', 'Laptop'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickHinhAnh,
                  child: Text('Chọn hình ảnh'),
                ),
                if (_hinhAnh != null) Image.file(_hinhAnh!, height: 100, width: 100), // Hiển thị hình ảnh đã chọn
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (maSanPhamController.text.isEmpty ||
                      tenSanPhamController.text.isEmpty ||
                      soLuongController.text.isEmpty ||
                      giaTienController.text.isEmpty ||
                      _hinhAnh == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Lỗi'),
                        content: Text('Vui lòng nhập đầy đủ thông tin và chọn hình ảnh.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    DocumentReference docRef = await _firestore.collection('quan_ly_kho').add({
                      'maSP': maSanPhamController.text,
                      'tenSP': tenSanPhamController.text,
                      'soLuong': int.parse(soLuongController.text),
                      'giaTien': int.parse(giaTienController.text),
                      'loaiSP': luaChonSanPham,
                    });

                    await _uploadHinhAnh(docRef.id);

                    await docRef.update({
                      'hinhAnhUrl': _hinhAnhUrl,
                    });

                    Navigator.of(context).pop();
                  }
                },
                child: Text('Thêm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _SuaSanPham(String docId, Map<String, dynamic> product) {
    TextEditingController maSanPhamController = TextEditingController(text: product['maSP']);
    TextEditingController tenSanPhamController = TextEditingController(text: product['tenSP']);
    TextEditingController soLuongController = TextEditingController(text: product['soLuong'].toString());
    TextEditingController giaTienController = TextEditingController(text: product['giaTien'].toString());

    String luaChonSanPham = product['loaiSP'];

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Sửa sản phẩm'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: maSanPhamController,
                  decoration: InputDecoration(labelText: 'Mã sản phẩm'),
                ),
                TextField(
                  controller: tenSanPhamController,
                  decoration: InputDecoration(labelText: 'Tên sản phẩm'),
                ),
                TextField(
                  controller: soLuongController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Số lượng'),
                ),
                TextField(
                  controller: giaTienController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Giá tiền'),
                ),
                DropdownButton<String>(
                  value: luaChonSanPham,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        luaChonSanPham = newValue;
                      });
                    }
                  },
                  items: <String>['Máy in', 'Hộp mực', 'Webcam'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickHinhAnh,
                  child: Text('Chọn hình ảnh mới'),
                ),
                if (_hinhAnh != null) Image.file(_hinhAnh!, height: 100, width: 100), // Hiển thị hình ảnh đã chọn
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await _uploadHinhAnh(docId);

                  await _firestore.collection('quan_ly_kho').doc(docId).update({
                    'maSP': maSanPhamController.text,
                    'tenSP': tenSanPhamController.text,
                    'soLuong': int.parse(soLuongController.text),
                    'giaTien': int.parse(giaTienController.text),
                    'loaiSP': luaChonSanPham,
                    'hinhAnhUrl': _hinhAnhUrl,
                  });

                  Navigator.of(context).pop();
                },
                child: Text('Cập nhật'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _xoaSanPham(String docId) {
    setState(() {
      _firestore.collection('quan_ly_kho').doc(docId).delete();
    });
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
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
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
              leading: Icon(Icons.local_shipping),
              title: Text('Quản lý kho'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Quan_Ly_Kho');
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Thống kê'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Thong_Ke');
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('quan_ly_kho').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Center(child: Text('STT'))),
                  DataColumn(label: Center(child: Text('Mã sản phẩm'))),
                  DataColumn(label: Center(child: Text('Loại sản phẩm'))),
                  DataColumn(label: Center(child: Text('Tên sản phẩm'))),
                  DataColumn(label: Center(child: Text('Số lượng'))),
                  DataColumn(label: Center(child: Text('Giá tiền'))),
                  DataColumn(label: Center(child: Text('Hình ảnh'))),
                  DataColumn(label: Center(child: Text('Hành động'))),
                ],
                rows: products.asMap().entries.map((entry) {
                  int index = entry.key;
                  var product = entry.value.data();
                  var docId = entry.value.id;

                  // Kiểm tra và xử lý trường hợp null trước khi truy cập thuộc tính
                  String maSP = (product as Map<String, dynamic>?)?['maSP']?.toString() ?? '';
                  String loaiSP = (product as Map<String, dynamic>?)?['loaiSP']?.toString() ?? '';
                  String tenSP = (product as Map<String, dynamic>?)?['tenSP']?.toString() ?? '';
                  String soLuong = (product as Map<String, dynamic>?)?['soLuong']?.toString() ?? '';
                  String giaTien = (product as Map<String, dynamic>?)?['giaTien']?.toString() ?? '';
                  String hinhAnhUrl = (product as Map<String, dynamic>?)?['hinhAnhUrl']?.toString() ?? '';

                  return DataRow(cells: [
                    DataCell(Center(child: Text((index + 1).toString()))),
                    DataCell(Center(child: Text(maSP))),
                    DataCell(Center(child: Text(loaiSP))),
                    DataCell(Center(child: Text(tenSP))),
                    DataCell(Center(child: Text(soLuong))),
                    DataCell(Center(child: Text(giaTien))),
                    DataCell(Center(
                      child: hinhAnhUrl.isNotEmpty
                          ? Image.network(hinhAnhUrl, height: 50, width: 50)
                          : Text('Không có ảnh'),
                    )),
                    DataCell(
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _SuaSanPham(docId, product as Map<String, dynamic>), // Sửa sản phẩm
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => _xoaSanPham(docId), // Xóa sản phẩm
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _themSanPham,
        child: Icon(Icons.add),
      ),
    );
  }
}
