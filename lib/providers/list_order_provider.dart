import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodorder_app/models/order_model.dart';

class ListOrderProvider with ChangeNotifier {
  List<OrderModel> listOrder = [];
  getListOrderData() async {
    List<OrderModel> newList = [];
    OrderModel orderModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("MyOrders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      orderModel = OrderModel(
        list_order_item: _db.get("orderItems"),
      );
      newList.add(orderModel);
      notifyListeners();
    }

    listOrder = newList;
    notifyListeners();
  }

  List<OrderModel> get getListOrder {
    return listOrder;
  }
}
