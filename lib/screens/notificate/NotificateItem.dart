import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// class NotificateItem extends StatelessWidget {
//   final int? id;
//   final String? title;
//   NotificateItem({this.id, this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 150,
//     );
//   }
// }

class NotificationItem extends StatelessWidget {
  final String? title;
  final String? message;
  final String? time;

  NotificationItem({this.title, this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        title: Text(
          title ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          message ?? '',
          maxLines: 2,
        ),
        trailing: Text(
          time ?? '',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
