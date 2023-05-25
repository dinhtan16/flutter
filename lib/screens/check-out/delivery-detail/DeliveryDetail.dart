import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/models/delivery_address_model.dart';
import 'package:foodorder_app/providers/check_out_provider.dart';
// import 'package:foodorder_app/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:foodorder_app/screens/check-out/delivery-detail/single_delivery_item.dart';
import 'package:foodorder_app/screens/home/HomeScreen.dart';
// import 'package:foodorder_app/screens/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel? value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn địa chỉ giao hàng"),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => AddDeliverAddress(

          //     ),
          //   ),
          // );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text(
                  "Thêm địa chỉ mới",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              : Text("Payment Summary"),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                          // deliverAddressList: value,
                          ),
                    ),
                  );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Giao hàng đến",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            leading: Icon(
              Icons.local_shipping,
              color: Colors.black,
              size: 40,
            ),
          ),
          Divider(
            height: 2,
            color: Color.fromARGB(255, 86, 86, 86),
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(
                    child: Text("Địa chỉ mặc định trống"),
                  ),
                )
              : Column(children: [
                  SingleDeliveryItem(
                    title: 'haha',
                    address: 'ronaldo',
                    addressType: 'home',
                    number: '0393296011',
                  )
                ]
                  // deliveryAddressProvider.getDeliveryAddressList
                  //     .map<Widget>((e) {
                  //   setState(() {
                  //     value = e;
                  //   });
                  //   return SingleDeliveryItem(
                  //     address:
                  //         "aera, ${e.aera}, street, ${e.street}, society ${e.scoirty}, pincode ${e.pinCode}",
                  //     title: "${e.firstName} ${e.lastName}",
                  //     number: e.mobileNo,
                  //     addressType: e.addressType == "AddressTypes.Home"
                  //         ? "Home"
                  //         : e.addressType == "AddressTypes.Other"
                  //             ? "Other"
                  //             : "Work",
                  //   );
                  // }).toList(),
                  )
        ],
      ),
    );
  }
}
