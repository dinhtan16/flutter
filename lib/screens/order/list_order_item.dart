import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/screens/check-out/payment/order_item.dart';
import 'package:intl/intl.dart';

class ListOrderItem extends StatelessWidget {
  // const MyWidget({super.key});
  String? order_id;
  List<dynamic>? list_order;
  bool? order_status;
  Timestamp? order_at;
  ListOrderItem(
      {this.order_id, this.list_order, this.order_status, this.order_at});
  @override
  Widget build(BuildContext context) {
    int ts = 1638592424384;
    DateTime tsdate =
        DateTime.fromMillisecondsSinceEpoch(order_at!.nanoseconds);
    String fdatetime = DateFormat('dd-MMM-yyy')
        .format(tsdate); //DateFormat() is from intl package
    return GestureDetector(
      onTap: () {
        print(order_id);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: Image.network(
            'https://foodcoin-app.com/wp-content/uploads/2021/06/Logo-Foodcoin.png',
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(
            "Đơn hàng : ${order_id!}",
            maxLines: 1,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(fdatetime.toString()),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: order_status == false ? primaryColor : Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              order_status == false ? "Đang giao" : "Đã hủy",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
