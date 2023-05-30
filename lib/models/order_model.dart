import 'package:foodorder_app/screens/check-out/payment/order_item.dart';

class OrderModel {
  String? orderId;
  double? total;
  DateTime? order_create_at;
  List<OrderItem> list_order_item;
  OrderModel(
      {this.orderId,
      this.total,
      required this.list_order_item,
      this.order_create_at});
}
