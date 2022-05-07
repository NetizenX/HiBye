import 'package:flutter/material.dart';
import 'package:hibye/constants.dart';
import 'package:hibye/model/order_item.dart';
import 'package:hibye/currency.dart';
import 'package:provider/provider.dart';
import 'package:hibye/model/data.dart';
// import 'package:hibye/screen_size.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem? orderItem;
  int index;

  OrderItemTile({required int this.index, required OrderItem? this.orderItem});

  @override
  Widget build(BuildContext context) {
    if (orderItem == null) {
      return Container();
    } else {
      return Dismissible(
        onDismissed: (direction) => Provider.of<Data>(context, listen: false)
            .removeFromOrder(index: index),
        key: UniqueKey(),
        child: Container(
          width: 10.0,
          margin: EdgeInsets.symmetric(vertical: 5.0),
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: kAppTextColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '(${orderItem!.quantity}) ' + orderItem!.item,
              ),
              Text(
                currencyString(orderItem!.subTotal),
              ),
            ],
          ),
        ),
      );
    }
  }
}
