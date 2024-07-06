import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Gio_Hang extends StatefulWidget {
  const Gio_Hang({Key? key}) : super(key: key);

  @override
  _Gio_HangState createState() => _Gio_HangState();
}

class _Gio_HangState extends State<Gio_Hang> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  int soLuong = 1;
  int soLuong2 = 1;
  int gia = 3000000;
  int gia2 = 4000000;
  int? tong;
  int? tongTatCa;
  int? datCoc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Giỏ hàng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            color: Colors.orange,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(icon: Icon(Icons.shopping_cart,), text: 'Giỏ hàng'),
                Tab(icon: Icon(Icons.star), text: 'Đã đặt cọc'),
              ],
            ),
          ),
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10)),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.print, size: 90,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('MÁY IN MÀU CANON',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Text('Còn hàng',
                                style: TextStyle(color: Colors.green),),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        if(soLuong <= 1)
                                          soLuong = 1;
                                        else
                                          soLuong -= 1;
                                      });
                                    }, 
                                    icon: Icon(Icons.remove)),

                                  Text('$soLuong'),
                              
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        soLuong+=1;
                                      });
                                    }, 
                                    icon: Icon(Icons.add)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text('Giá bán: ',
                            style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                          Text('3,000,000đ',
                            style: TextStyle(color: Colors.red, fontSize: 15),),
                        ],
                      ),

                      Row(
                        children: [
                          Text('Tổng: ',
                            style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                          Text('${NumberFormat('#,###', 'en_US').format(gia*soLuong)}đ',
                            style: TextStyle(color: Colors.red, fontSize: 15),),

                          Spacer(),

                          IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.delete, size: 30,),
                            color: Colors.black,
                            )
                        ],
                      )
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.all(5)),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.print, size: 90,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('MÁY IN BROTHER',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Text('Còn hàng',
                                style: TextStyle(color: Colors.green),),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        if(soLuong2 <= 1)
                                          soLuong2 = 1;
                                        else
                                          soLuong2 -= 1;
                                      });
                                    }, 
                                    icon: Icon(Icons.remove)),

                                  Text('$soLuong2'),
                              
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        soLuong2+=1;
                                      });
                                    }, 
                                    icon: Icon(Icons.add)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text('Giá bán: ',
                            style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                          Text('4,000,000đ',
                            style: TextStyle(color: Colors.red, fontSize: 15),),
                        ],
                      ),

                      Row(
                        children: [
                          Text('Tổng: ',
                            style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                          Text('${NumberFormat('#,###', 'en_US').format(gia2*soLuong2)}đ',
                            style: TextStyle(color: Colors.red, fontSize: 15),),

                          Spacer(),

                          IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.delete, size: 30,),
                            color: Colors.black,
                            )
                        ],
                      )
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.all(5.0)),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: 
                    Row(
                      children: [
                        Text('Tổng giá trị: ',
                            style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                         Spacer(), 
                        Text('${NumberFormat('#,###', 'en_US').format(gia*soLuong + gia2*soLuong2)}đ',
                            style: TextStyle(color: Colors.red, fontSize: 15),),
                      ],
                    ),
                ),

                Padding(padding: EdgeInsets.all(2)),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: 
                    Row(
                      children: [
                        Text('Đặt cọc: ',
                            style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                         Spacer(), 
                        Text('${NumberFormat('#,###', 'en_US').format((gia*soLuong + gia2*soLuong2)*0.3)}đ',
                            style: TextStyle(color: Colors.red, fontSize: 15),),
                      ],
                    ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),

                Column(
                  children: [
                    ElevatedButton(
                    onPressed: (){
                      Navigator.popUntil(context, (route) => route.isCurrent);
                        Navigator.pushNamed(context, '/Dat_Hang');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    ),
                    child: Text('Đặt hàng')),
                  ],
                )
              ],
            ),),
            ),
          ),

          Center(
            child: Column(
                  children: [
                    ElevatedButton(
                    onPressed: (){
                      // Navigator.popUntil(context, (route) => route.isCurrent);
                      //   Navigator.pushNamed(context, '/Dat_Hang');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    ),
                    child: Text('Thanh toán')),
                  ],
                ),
          )
        ],
      )
    );
  }
}
