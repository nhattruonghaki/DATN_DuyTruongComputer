import 'package:flutter/material.dart';

class Dat_Hang extends StatefulWidget {
  Dat_Hang({super.key});

  @override
  State<Dat_Hang> createState() => _Dat_HangState();
}

class _Dat_HangState extends State<Dat_Hang> {
  final List<String> _paymentMethods = ['Tiền mặt', 'Momo', 'Ngân hàng'];
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Đặt hàng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Text('Thông tin thanh toán',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Họ và tên',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Họ tên khách hàng',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Số điện thoại',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Dùng để liên lạc',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Nhập Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Địa chỉ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Địa chỉ nhận hàng',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),

                Text('Hãy chọn hình thức thanh toán',
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
                    }
                ),
                Padding(padding: EdgeInsets.all(5)),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  onPressed: (){
                    // Navigator.popUntil(context, (route) => route.isCurrent);
                    //   Navigator.pushNamed(context, '/Dat_Hang');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text('Đặt hàng',
                    style: TextStyle(fontSize: 25),)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}