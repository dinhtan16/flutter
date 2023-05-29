import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/screens/check-out/payment/order_item.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

enum PaymentTypes {
  Cod,
  Banking,
}

class _PaymentState extends State<Payment> {
  var myType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myType = PaymentTypes.Cod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết đặt hàng'),
          backgroundColor: primaryColor,
        ),
        bottomNavigationBar: Container(
          height: 60,
          // padding: EdgeInsets.all(20),
          padding: EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 10),
          child: MaterialButton(
            onPressed: () {},
            child: Text(
              'Hoàn tất đặt hàng',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Thông tin nhận hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'NguThanh Hiếu',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '828 sư vạn hạnh , pphường 13 , quận 10 , thành phố hồ chí minh',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '0393296011',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Chi tiết đơn hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                childrenPadding: EdgeInsets.only(bottom: 20),
                children: [
                  OrderItem(),
                  SizedBox(
                    height: 10,
                  ),
                  OrderItem(),
                  SizedBox(
                    height: 10,
                  ),
                  OrderItem(),
                  SizedBox(
                    height: 10,
                  ),
                  OrderItem(),
                  SizedBox(
                    height: 10,
                  ),
                  OrderItem(),
                ],
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  'Tạm tính',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                trailing: Text(
                  '200.000đ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 86, 86, 86)),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text('Phí vận chuyển',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                trailing: Text(
                  '20.000đ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 86, 86, 86)),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text('Khuyến mãi',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                trailing: Text(
                  '0đ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 86, 86, 86)),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text('Tổng tiền',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                trailing: Text('200.000đ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Divider(),
              ListTile(
                leading: Text(
                  'Chọn phương thức thanh toán',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              RadioListTile(
                activeColor: primaryColor,
                title: Text('Thanh toán khi nhận hàng'),
                value: PaymentTypes.Cod,
                groupValue: myType,
                onChanged: (value) {
                  setState(() {
                    myType = value;
                  });
                },
              ),
              RadioListTile(
                activeColor: primaryColor,
                title: Text('Chuyển khoản'),
                value: PaymentTypes.Banking,
                groupValue: myType,
                onChanged: (value) {
                  setState(() {
                    myType = value;
                  });
                },
              )
            ],
          ),
        ));
  }
}
