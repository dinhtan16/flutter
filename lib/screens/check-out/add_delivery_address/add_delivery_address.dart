import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/screens/check-out/add_delivery_address/custom_text_field.dart';

import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myType = AddressTypes.Home;
  }

  @override
  Widget build(BuildContext context) {
    // CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Thêm địa chỉ mới",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            "Thêm mới",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(labelText: 'Họ'),
            CustomTextField(labelText: 'Tên'),
            CustomTextField(labelText: 'Số điện thoại'),
            CustomTextField(labelText: 'Số Nhà'),
            CustomTextField(labelText: 'Đường'),
            CustomTextField(labelText: 'Phường / Xã'),
            CustomTextField(labelText: 'Quận'),
            CustomTextField(labelText: 'Thành Phố'),
            InkWell(
              onTap: () => {},
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Vị trí cụ thể')],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Loại địa chỉ"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Nhà riêng"),
              onChanged: (value) {
                setState(() {
                  myType = value;
                });
                // print(value);
              },
              secondary: Icon(Icons.home, color: Colors.black),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Công ty"),
              onChanged: (value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.work_sharp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
