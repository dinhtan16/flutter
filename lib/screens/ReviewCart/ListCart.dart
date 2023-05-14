import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder_app/models/review_cart_model.dart';
import 'package:foodorder_app/providers/review_cart_provider.dart';
import 'package:foodorder_app/screens/check-out/delivery-detail/DeliveryDerail.dart';
import 'package:foodorder_app/screens/widgets/SingleItem.dart';
import 'package:provider/provider.dart';

class ListCart extends StatelessWidget {
  ReviewCartProvider? reviewCartProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = FloatingActionButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FloatingActionButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider?.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider?.getReviewCartData();
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
            "\ ${reviewCartProvider?.getTotalPrice()}VND",
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
            onPressed: () {
              if (reviewCartProvider!.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(msg: "No Cart Data Found");
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryDetails(),
                ),
              );
            },
          ),
        ),
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 40, right: 20, left: 20),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
        title: Text('Giỏ hàng'),
      ),
      body: reviewCartProvider?.getReviewCartDataList.length == 0
          ? Center(
              child: Text(
                "Giỏ hàng trống!!!",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: reviewCartProvider?.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider!.getReviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleItem(
                      isBool: false,
                      wishList: false,
                      productImage: data.cartImage,
                      productName: data.cartName,
                      productPrice: data.cartPrice,
                      productId: data.cartId,
                      productQuantity: data.cartQuantity,
                      // productUnit: data.cartUnit,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
