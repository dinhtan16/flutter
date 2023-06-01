import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/providers/list_order_provider.dart';
import 'package:foodorder_app/screens/order/list_order_item.dart';
import 'package:foodorder_app/screens/order/order_detail.dart';
import 'package:provider/provider.dart';

class ListOrder extends StatelessWidget {
  // const ListOrder({super.key});
  ListOrderProvider? listOrderProvider;
  @override
  Widget build(BuildContext context) {
    listOrderProvider = Provider.of<ListOrderProvider>(context);
    listOrderProvider?.getListOrderData();
    print(listOrderProvider!.getListOrder);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Danh sách đơn hàng của bạn"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listOrderProvider!.getListOrder.length,
        itemBuilder: (BuildContext context, int index) {
          return ListOrderItem(
            order_id: listOrderProvider!.getListOrder[index].order_id,
            order_status: listOrderProvider!.getListOrder[index].is_delivery,
            list_order: listOrderProvider!.getListOrder[index].list_order_item,
            order_at: listOrderProvider!.getListOrder[index].order_create_at,
            onTab: () {
              MaterialPageRoute(builder: (context) => OrderDetail());
            },
          );
        },
      ),
    );
  }
}
