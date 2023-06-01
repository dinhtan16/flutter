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
        SizedBox(height: 10),
        ListTile(
          leading: Checkbox(
            checkColor: Colors.white,
            // fillColor: Colors.black,
            value: false,
            onChanged: (bool? value) {},
          ),
          title: Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                address!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                number!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: Text(
              addressType!,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
