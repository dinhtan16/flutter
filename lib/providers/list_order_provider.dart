import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodorder_app/models/order_model.dart';

class ListOrderProvider with ChangeNotifier {
  OrderModel? orderModel;
  orderModels(QueryDocumentSnapshot element) {
    orderModel = OrderModel(
        order_id: element.get("order_id"),
        order_create_at: element.get("order_at"),
        list_order_item: element.get("order_items"),
        total: element.get('order_total'),
        is_delivery: element.get('is_delivery'),
        order_payment_type: element.get('order_payment_type'),
        order_info: element.get('order_info'));
  }

  List<OrderModel> listOrder = [];
  getListOrderData() async {
    try {
      List<OrderModel> newList = [];
      QuerySnapshot result = await FirebaseFirestore.instance
          .collection("Order")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MyOrders")
          .get();
      result.docs.forEach((element) {
        orderModels(element);
        newList.add(orderModel!);
      });
      listOrder = newList;
      await Future.delayed(Duration(seconds: 30), () {
        // notifyListeners();
      });
    } catch (e) {
      print("get list order failed : ${e}");
    }
  }

  List<OrderModel> get getListOrder {
    return listOrder;
  }
}
