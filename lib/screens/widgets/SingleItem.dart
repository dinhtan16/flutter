import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';

class SingleItem extends StatelessWidget {
  bool? isCart = false;

  final String? productName;
  final String? productImage;
  final String? productId;
  final String? productPrice;

  SingleItem(
      {this.isCart,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice});

  CurrencyFormatterSettings currencySettings = CurrencyFormatterSettings(
    symbol: 'đ',
    symbolSide: SymbolSide.right,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  @override
  Widget build(BuildContext context) {
    var priceNumber = 0;
    try {
      int nums = int.parse(productPrice!);
      priceNumber = nums;
    } catch (e) {
      print('Chuỗi không thể chuyển đổi thành số: $e');
    }
    String formattedPrice =
        CurrencyFormatter.format(priceNumber, currencySettings);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 100,
            child: Center(
              child: Image.network(productImage!),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: isCart == false
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    Text(
                      formattedPrice ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                isCart == false
                    ? Container(
                        margin: EdgeInsets.only(right: 15, top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                      )
                    : Container(
                        width: 90,
                        margin: EdgeInsets.only(top: 5),
                        // child: Text(
                        //   // 'Đơn vị: 50 gram'
                        //   'SL : 1',
                        //   style: TextStyle(
                        //       fontSize: 15, fontWeight: FontWeight.w500),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(2, 134, 17, 1),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 42, 42, 42)),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(2, 134, 17, 1)
                                    // color: Colors.red
                                    ,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(5),
              decoration: isCart == false
                  ? BoxDecoration(
                      color: Color.fromRGBO(2, 134, 17, 1),
                      borderRadius: BorderRadius.circular(30),
                    )
                  : BoxDecoration(
                      color: Color.fromARGB(255, 214, 214, 214),
                      borderRadius: BorderRadius.circular(30),
                    ),
              child: isCart == false
                  ? Center(
                      child: Container(
                          child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      )),
                    )
                  : Center(
                      child: Icon(
                        Icons.delete_outlined,
                        color: Color.fromARGB(255, 42, 42, 42),
                        size: 20,
                      ),
                    )),
        ),
      ],
    );
  }
}
