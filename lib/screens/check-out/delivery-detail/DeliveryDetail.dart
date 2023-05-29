import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/providers/check_out_provider.dart';
import 'package:foodorder_app/screens/check-out/add_delivery_address/add_delivery_address.dart';
import 'package:foodorder_app/screens/check-out/delivery-detail/single_delivery_item.dart';
import 'package:foodorder_app/screens/check-out/payment/payment.dart';
import 'package:foodorder_app/screens/home/HomeScreen.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  //  DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Trở lại"),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(),
            ),
          );
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
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              : Text(
                  "Tiếp tục thanh toán",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDeliverAddress(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Payment(
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
            title: Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 35,
                  color: Color.fromARGB(255, 28, 28, 28),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Giao hàng đến địa chỉ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color.fromARGB(255, 42, 42, 42),
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height - 250,
                  child: Center(
                    child: Text(
                      "Đỉa chỉ mặc định trống",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 53, 53, 53)),
                    ),
                  ),
                )
              : Column(
                  children: [
                    SingleDeliveryItem(
                      title: 'Thanh Hiếu',
                      number: '0393297011',
                      address:
                          '828 sư vạn hạnh , phường 13 , quận 10 , thành phố Hồ Chí Minh',
                      addressType: 'công ty',
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
