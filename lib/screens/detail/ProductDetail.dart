import 'package:flutter/material.dart';
import 'package:foodorder_app/screens/home/ProductCart.dart';
import 'package:currency_formatter/currency_formatter.dart';

enum SigningCharacter { fill, outline }

class ProductDetail extends StatefulWidget {
  final String? productName;
  final String? productImage;
  final String? productId;
  final String? productDes;

  final String? productPrice;

  ProductDetail(
      {this.productName,
      this.productImage,
      this.productPrice,
      this.productId,
      this.productDes});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  SigningCharacter _character = SigningCharacter.fill;
  Widget BottomBar(
      {Color? iconColor,
      Color? textColor,
      Color? backgroundColor,
      String? title,
      IconData? iconData}) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        height: 50,
        // color: backgroundColor,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 218, 214, 214),
                blurRadius: 10,
                offset: Offset(1, 1), // Shadow position
              ),
            ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(iconData, size: 17, color: iconColor),
          SizedBox(
            width: 5,
          ),
          Text(title.toString(),
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 16))
        ]),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    CurrencyFormatterSettings currencySettings = CurrencyFormatterSettings(
      symbol: 'đ',
      symbolSide: SymbolSide.right,
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolSeparator: ' ',
    );

    var priceNumber = 0;
    try {
      int nums = int.parse(widget.productPrice!);
      priceNumber = nums;
    } catch (e) {
      print('Chuỗi không thể chuyển đổi thành số: $e');
    }
    String formattedPrice =
        CurrencyFormatter.format(priceNumber, currencySettings);
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 0, right: 10, bottom: 30, left: 10),
        child: Row(children: [
          BottomBar(
              backgroundColor: Colors.white,
              iconColor: Colors.black,
              iconData: Icons.favorite_border_outlined,
              title: 'Yêu thích'),
          BottomBar(
              backgroundColor: Color.fromRGBO(2, 134, 17, 1),
              iconColor: Colors.white,
              iconData: Icons.shopping_cart_checkout_outlined,
              title: 'Thanh toán',
              textColor: Colors.white)
        ]),
      ),
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Chi tiết sản phẩm',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(children: [
        Container(
            width: double.infinity,
            height: 280,
            // width: double.infinity,
            child: FittedBox(
                child: Image.network(widget.productImage!), fit: BoxFit.fill)),
        ListTile(
          title: Text(
            widget.productName ?? '',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Text(
                  formattedPrice,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(60, 42, 33, 1)),
                )
              ],
            ),
          ]),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mô tả',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      widget.productDes ?? '',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
