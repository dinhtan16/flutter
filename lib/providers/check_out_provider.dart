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
    var idRef = generateId(20);
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
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(idRef)
          .set({
        "address_id": idRef,
        "fullname": fullname.text,
        "phone": phone.text,
        "street": street.text,
        "ward": ward.text,
        "district": district.text,
        "city": city.text,
        "addressType": myType == AddressTypes.Work ? 'Công ty' : 'Nhà riêng',
        // "longitude": setLoaction!.longitude,
        // "latitude": setLoaction!.latitude,
      }).then((value) async {
        await Future.delayed(Duration(seconds: 1), () {
          Fluttertoast.showToast(
              msg: "Thêm địa chỉ mới thành công",
              backgroundColor: Colors.green);
        });
        notifyListeners();

        Navigator.of(context).pop();
      });
      notifyListeners();
    }
  }

  DeliveryAddressModel? deliveryAddressModel;
  deliveryAddressModels(QueryDocumentSnapshot element) {
    deliveryAddressModel = DeliveryAddressModel(
        address_id: element.get("address_id"),
        fullname: element.get("fullname"),
        phone: element.get("phone"),
        street: element.get("street"),
        ward: element.get('ward'),
        district: element.get('district'),
        city: element.get('city'),
        addressType: element.get('addressType'));
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection("AddDeliverAddress").get();
    result.docs.forEach((element) {
      deliveryAddressModels(element);
      newList.add(deliveryAddressModel!);
    });
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
