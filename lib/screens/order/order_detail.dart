import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/providers/list_order_provider.dart';
import 'package:foodorder_app/screens/order/list_order.dart';
import 'package:foodorder_app/screens/order/map.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatelessWidget {
  String? order_id;
  Timestamp? order_at;
  String? order_total;
  bool? order_status;
  List<dynamic>? items;
  List<dynamic>? info_address;
  OrderDetail(
      {this.order_id,
      this.order_at,
      this.info_address,
      this.order_total,
      this.order_status,
      this.items});

  static String routeName = "/OrderDetail";
  @override
  Widget build(BuildContext context) {
    var listOrderProvider = Provider.of<ListOrderProvider>(context);
    var convertAdd = info_address!.elementAt(0);
    var formatAddress =
        "${convertAdd["street"]} , Phường ${convertAdd["ward"]} , Quận ${convertAdd["district"]} , Thành phố ${convertAdd["city"]}";

    CurrencyFormatterSettings currencySettings = CurrencyFormatterSettings(
      symbol: 'đ',
      symbolSide: SymbolSide.right,
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolSeparator: ' ',
    );
    String formatTotalPrice =
        CurrencyFormatter.format(order_total, currencySettings);

    final date = DateTime.fromMillisecondsSinceEpoch(
        order_at!.seconds * 1000 + (order_at!.nanoseconds / 1000000).round());
    final formattedDate = DateFormat('dd-MM-yyyy').format(date);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Chi tiết đơn hàng"),
      ),
      bottomNavigationBar: order_status == true
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: MaterialButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Bạn muốn hủy đơn hàng?'),
                      content: const Text(
                          'Bạn chắc chắn chứ , nếu hủy bạn sẽ bị vào blacklist'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async => {
                            await listOrderProvider
                                .cancelOrder(order_id.toString()),
                            Fluttertoast.showToast(
                              msg: "Hủy đơn hàng thành công",
                              backgroundColor: primaryColor,
                            ),
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     "/ListOrder",
                            //     ModalRoute.withName("/OrderDetail")),
                            Navigator.pop(context)
                          },
                          child: const Text(
                            'Đồng ý',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                height: 45,
                child: Text(
                  "Hủy đơn hàng",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                color: Color.fromARGB(255, 194, 1, 1),
              ),
            )
          : null,
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Đơn hàng #${order_id}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text('Khách hàng:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(convertAdd!["owner_order"])
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('Điện thoại:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(convertAdd!["phone"])
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Địa Chỉ:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            formatAddress,
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('Ngày tạo:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(formattedDate)
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Tổng tiền:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          formatTotalPrice,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('Trạng thái:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          order_status == true ? "Đang giao" : "Đã hủy",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: order_status == true
                                  ? primaryColor
                                  : Color.fromARGB(255, 194, 1, 1)),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                      title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.navigate_next, color: Colors.blueAccent),
                        Text('Theo dõi đơn hàng',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Danh sách sản phẩm:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items!.length,
                itemBuilder: (BuildContext context, int index) {
                  String formatProductPrice = CurrencyFormatter.format(
                      items![index]["productPrice"], currencySettings);

                  return ListTile(
                    leading: Image.network(
                      items![index]["productImage"],
                      width: 60,
                      height: 60,
                      colorBlendMode: BlendMode.dstOut,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(items![index]["productName"],
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text("x${items![index]["productQuantity"]}",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          formatProductPrice,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
