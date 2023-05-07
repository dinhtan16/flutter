import 'package:flutter/material.dart';
import 'package:foodorder_app/screens/widgets/SingleItem.dart';

class ListCart extends StatelessWidget {
  const ListCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text(
          'Tổng tiền:',
          style: TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.w600),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            '1.000.000đ',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(223, 46, 56, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
        trailing: Container(
          child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
            child: Text(
              'Thanh toán',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            color: Color.fromRGBO(2, 134, 17, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {},
          ),
        ),
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 40, right: 20, left: 20),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
        title: Text('Giỏ hàng'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          ),
          SingleItem(isCart: true),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
