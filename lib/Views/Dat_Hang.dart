import 'package:do_an_tot_nghiep/ViewModels/FB_AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dat_Hang extends StatefulWidget {
  Dat_Hang({super.key});

  @override
  State<Dat_Hang> createState() => _Dat_HangState();
}

class _Dat_HangState extends State<Dat_Hang> {
  final List<String> _paymentMethods = ['Tiền mặt', 'Momo', 'Ngân hàng'];
  String? _selectedPaymentMethod;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _hoVaTen = TextEditingController();
  final TextEditingController _sDT = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _diaChi = TextEditingController();

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

  void _showDatHangThanhCong(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thành Công'),
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

  void _donDatHang(int giaTien, int soLuong, String maSP) async {
    String _hovaten = _hoVaTen.text;
    String _sdt = _sDT.text;
    String _diachi = _diaChi.text;
    String paymentMethod = _selectedPaymentMethod ?? 'Tiền mặt';

    if (_hovaten.isEmpty ||
        _sdt.isEmpty ||
        _diachi.isEmpty ||
        _selectedPaymentMethod == null) {
      _showErrorDialog("Vui lòng điền tất cả các trường");
      return;
    }

    try {
      // Lấy email từ tài khoản đăng nhập hiện tại
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String email = user.email ?? "";

        await _auth.saveDonHang(user.uid, _hovaten, _sdt, _diachi,
            paymentMethod, giaTien, soLuong, maSP, email);
        print('Đặt hàng thành công');
        String message = 'Đặt hàng thành công với sản phẩm $maSP';

        // Show success dialog with the message
        _showDatHangThanhCong(message);
        Navigator.pushNamed(context, '/Trang_Chu');
      } else {
        _showErrorDialog("Vui lòng đăng nhập để đặt hàng.");
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog("Đặt hàng thất bại. Vui lòng thử lại.");
    } catch (e) {
      _showErrorDialog("Đặt hàng thất bại. Vui lòng thử lại.");
      print('Lỗi không xác định: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int giaTien = args['giaTien'];
    final int soLuong = args['soLuong'];
    final String maSP = args['maSP'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Đặt hàng',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Text(
            'Thông tin thanh toán',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Họ và tên',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextField(
                      controller: _hoVaTen,
                      decoration: InputDecoration(
                        labelText: 'Họ tên khách hàng',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Số điện thoại',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextField(
                      controller: _sDT,
                      decoration: InputDecoration(
                        labelText: 'Dùng để liên lạc',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextField(
                      controller: _diaChi,
                      decoration: const InputDecoration(
                        labelText: 'Địa chỉ nhận hàng',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  'Hãy chọn hình thức thanh toán',
                  style: TextStyle(fontSize: 15, color: Colors.green),
                ),
                DropdownButton<String>(
                    value: _selectedPaymentMethod,
                    hint: Text('Chọn hình thức thanh toán'),
                    items: _paymentMethods.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPaymentMethod = newValue;
                      });
                    }),
                Padding(padding: EdgeInsets.all(5)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _donDatHang(giaTien, soLuong, maSP),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Đặt hàng',
                        style: TextStyle(fontSize: 25),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
