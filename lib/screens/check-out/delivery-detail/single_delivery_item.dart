import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String? title;
  final String? address;
  final String? number;
  final String? addressType;
  SingleDeliveryItem({this.title, this.addressType, this.address, this.number});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Center(
              child: CircleAvatar(
            radius: 8,
            backgroundColor: primaryColor,
          )),
          title: Text(title!),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(title!),
              // SizedBox(
              //   height: 5,
              // ),
              Text(address!),
              SizedBox(
                height: 5,
              ),
              Text(number!),
            ],
          ),
          trailing: Icon(Icons.more_vert),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
