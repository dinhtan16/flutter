import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrderItem extends StatelessWidget {
  bool? isTrue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 5,
      leading: Image.network(
        "https://gongcha.com.vn/wp-content/uploads/2022/06/Tra-sua-tran-chau-HK.png",
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Food name',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text("1",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text('10.000.000d',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
        ],
      ),
    );
  }
}
