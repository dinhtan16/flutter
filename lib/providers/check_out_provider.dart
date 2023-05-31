import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder_app/models/delivery_address_model.dart';
import 'package:foodorder_app/models/review_cart_model.dart';
import 'package:foodorder_app/screens/check-out/add_delivery_address/add_delivery_address.dart';
import 'package:location/location.dart';
import 'package:foodorder_app/config/id_generator.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController ward = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
  LocationData? setLoaction;

  void validator(context, myType) async {
    if (fullname.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fullname is not empty");
    } else if (phone.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone is not empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street is not empty");
    } else if (ward.text.isEmpty) {
      Fluttertoast.showToast(msg: "Ward is not empty");
    } else if (district.text.isEmpty) {
      Fluttertoast.showToast(msg: "District is not empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is not empty");
    }
    // else if (setLoaction == null) {
    //   Fluttertoast.showToast(msg: "setLoaction is empty");
    // }
    else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "fullname": fullname.text,
        "phone": phone.text,
        "street": street.text,
        "ward": ward.text,
        "district": district.text,
        "city": city.text,
        "addressType": myType == 'AddressTypes.Work' ? 'Công ty' : 'Nhà riêng',
        // "longitude": setLoaction!.longitude,
        // "latitude": setLoaction!.latitude,
      }).then((value) async {
        notifyListeners();
        await Future.delayed(Duration(seconds: 1), () {
          isloadding = true;
          Fluttertoast.showToast(
              msg: "Thêm địa chỉ mới thành công",
              backgroundColor: Colors.green);
        });
        Navigator.of(context).pop();

        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        fullname: _db.get("fullname"),
        phone: _db.get("phone"),
        street: _db.get("street"),
        ward: _db.get("ward"),
        district: _db.get("district"),
        city: _db.get("city"),
        addressType: _db.get("addressType"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

////// Order /////////
  Future<void> addOderData({
    List<ReviewCartModel>? orderItemList,
    String? total,
    List<DeliveryAddressModel>? orderInfo,
    String? paymentType,
  }) async {
    try {
      String idOrder = generateId(25);
      await FirebaseFirestore.instance
          .collection("Order")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MyOrders")
          .doc(idOrder)
          .set(
        {
          "order_id": idOrder,
          "is_delivery": false,
          "order_at": Timestamp.now(),
          "order_total": total,
          "order_payment_type": paymentType,
          "order_info": orderInfo!
              .map((e) => {
                    "owner_order": e.fullname,
                    "phone": e.phone,
                    "street": e.street,
                    "ward": e.ward,
                    "district": e.district,
                    "city": e.city,
                    "address_type": e.addressType
                  })
              .toList(),
          "order_items": orderItemList!
              .map((e) => {
                    "productName": e.cartName,
                    "productImage": e.cartImage,
                    "productPrice": e.cartPrice,
                    "productQuantity": e.cartQuantity
                  })
              .toList(),
        },
      );
    } catch (e) {
      print("add order failed : ${e}");
    }
  }
}
