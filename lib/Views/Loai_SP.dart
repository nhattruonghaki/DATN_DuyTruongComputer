import 'package:do_an_tot_nghiep/Models/Item_sp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'Chi_Tiet_SP.dart';

class Loai_SP extends StatefulWidget {
  final String loaiSP;

  const Loai_SP({Key? key, required this.loaiSP}) : super(key: key);

  @override
  State<Loai_SP> createState() => _Loai_SPState();
}

class _Loai_SPState extends State<Loai_SP> {
  late String dropdownValue = 'Tất cả';
  final TextEditingController _timKiem = TextEditingController();
  late List<ItemSp> items = [];
  List<ItemSp> filteredItems = [];

  String chuyenDoiDangTien(int giaTien) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0);
    return formatCurrency.format(giaTien);
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    filteredItems = items;
  }

  void fetchProducts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('quan_ly_kho').get();

    List<ItemSp> fetchedItems = snapshot.docs.map((doc) {
      return ItemSp(
        tensp: doc['tenSP'],
        masp: doc['maSP'],
        hinhanh: doc['hinhAnhUrl'],
        loaisp: doc['loaiSP'],
        gia: doc['giaTien'],
        sl: doc['soLuong'],
      );
    }).toList();

    setState(() {
      items = fetchedItems;
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
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
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
                Scaffold.of(context).openDrawer(); // Open drawer
              },
            );
          },
        ),
      ),
      body: Column(
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
                            vertical: 12.0, horizontal: 12),
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            filterSearchResults(_timKiem.text);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      if (newValue == 'Tất cả') {
                        Navigator.pushNamed(context, '/Trang_Chu');
                      }
                      else if (newValue == 'Máy in' || newValue == 'Laptop') {
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                if (item.loaisp != widget.loaiSP && widget.loaiSP != "Tất cả")
                  return Container();
                return buildProductCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    List<ItemSp> searchResult = items.where((item) =>
        item.masp.toLowerCase().contains(query.toLowerCase()) ||
        item.loaisp.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      items = searchResult;
    });
  }

  Widget buildProductCard(ItemSp item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChiTietSp(item: item),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.hinhanh,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.tensp}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    chuyenDoiDangTien(item.gia),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Tình trạng: ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Icon(
                        item.sl > 0 ? Icons.check_circle : Icons.cancel,
                        color: item.sl > 0 ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      Text(
                        item.sl > 0 ? 'Còn hàng' : 'Hết hàng',
                        style: TextStyle(
                          color: item.sl > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}