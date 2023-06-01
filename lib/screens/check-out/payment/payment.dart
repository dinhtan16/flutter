import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/config/id_generator.dart';
import 'package:foodorder_app/providers/check_out_provider.dart';
import 'package:foodorder_app/providers/review_cart_provider.dart';
import 'package:foodorder_app/screens/ReviewCart/ListCart.dart';
import 'package:foodorder_app/screens/check-out/payment/order_item.dart';
import 'package:foodorder_app/screens/home/HomeScreen.dart';
import 'package:provider/provider.dart';

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
  int? shipping;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myType = PaymentTypes.Cod;
    shipping = 30000;
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đặt hàng'),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: reviewCartProvider.getReviewCartDataList.isEmpty
          ? null
          : Container(
              height: 60,
              // padding: EdgeInsets.all(20),
              padding: EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 10),
              child: MaterialButton(
                onPressed: () async => {
                  if (myType != PaymentTypes.Banking)
                    {
                      await deliveryAddressProvider.addOderData(
                        orderItemList: reviewCartProvider.getReviewCartDataList,
                        total: reviewCartProvider.getTotalPaymentPrice(
                            shipping: shipping!),
                        orderInfo:
                            deliveryAddressProvider.getDeliveryAddressList,
                        paymentType: myType.toString() == "PaymentTypes.Cod"
                            ? "Cod"
                            : "Banking",
                      ),
                      await Future.delayed(Duration(seconds: 1), () async {
                        // Fluttertoast.showToast(
                        //     msg: "Đặt hàng thành công",
                        //     backgroundColor: Colors.green);
                        await reviewCartProvider.deleteAllListCart();
                        await showDialog(
                            context: context,
                            builder: (BuildContextcontext) => AlertDialog(
                                  title: Text('Đặt hàng thành công'),
                                  content: Container(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Chúng tôi sẽ kiểm tra đơn hàng của bạn trong thời gian sớm nhất. Cảm ơn bạn đã đặt hàng !',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 60, 60, 60),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Bạn có muốn đặt thêm không?',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 60, 60, 60),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                      ),
                                      child: Text('Có'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Navigator.popUntil(
                                        //     context, ModalRoute.withName('/cart'));
                                      },
                                      child: Text('Hủy'),
                                    ),
                                  ],
                                ));
                      }),
                      setState(() {
                        shipping = 0;
                      })
                    }
                  else
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ),
                    }
                },
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
            Column(
              children: deliveryAddressProvider!.getDeliveryAddressList
                  .map(
                    (e) => ListTile(
                      title: Text(
                        'Thông tin nhận hàng',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Người nhận : ${e.fullname}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Địa chỉ : ${e.street} , Phường ${e.ward} , Quận ${e.district} , ${e.city}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Số điện thoại : ${e.phone}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${e.addressType}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            ExpansionTile(
                title: Text(
                  'Chi tiết đơn hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                childrenPadding: EdgeInsets.only(bottom: 20),
                children: reviewCartProvider.reviewCartDataList
                    .map(
                      (e) => OrderItem(
                        name: e.cartName,
                        quantity: e.cartQuantity.toString(),
                        price: e.cartPrice,
                        image: e.cartImage,
                      ),
                    )
                    .toList()),
            ListTile(
              minVerticalPadding: 5,
              leading: Text(
                'Tạm tính',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              trailing: Text(
                "${reviewCartProvider.getTotalPrice()}đ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 86, 86, 86)),
              ),
            ),
            ListTile(
              minVerticalPadding: 5,
              leading: Text('Phí vận chuyển',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              trailing: Text(
                "${shipping}đ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 86, 86, 86)),
              ),
            ),
            ListTile(
              minVerticalPadding: 5,
              leading: Text('Khuyến mãi',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
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
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              trailing: Text(
                  "${reviewCartProvider.getTotalPaymentPrice(shipping: shipping)}đ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
      ),
    );
  }
}
