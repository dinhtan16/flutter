import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:foodorder_app/screens/widgets/count.dart';

class ProductCart extends StatelessWidget {
  final String? productImage;
  final String? productName;
  final void Function()? onTap;
  final String? productId;
  final ProductModel? productUnit;
  final String? productPrice;

  ProductCart(
      {this.productImage,
      this.productName,
      this.onTap,
      this.productId,
      this.productUnit,
      this.productPrice});
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
      int nums = int.parse(productPrice!);
      priceNumber = nums;
    } catch (e) {
      print('Chuỗi không thể chuyển đổi thành số: $e');
    }
    String formattedPrice =
        CurrencyFormatter.format(priceNumber, currencySettings);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 280,
          width: 160,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                  onTap: onTap,
                  child: Container(
                      height: 120,
                      padding: EdgeInsets.all(0),
                      width: double.infinity,
                      child: Image.network(productImage!))),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      productName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  // Text(
                  //   '10k/4 bánh',
                  //   style: TextStyle(fontSize: 13),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      formattedPrice ?? '',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    child: Count(),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(2, 134, 17, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                          child: Text('Thêm vào giỏ',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            onTap!;
                          },
                        ),
                      ))
                ],
              ))
            ]),
          ),
        ),
      ]),
    );
  }
}

class ProductModel {}
