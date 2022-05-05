import 'package:flutter/material.dart';
import 'package:hibye/model/data.dart';
import 'package:provider/provider.dart';
import 'package:hibye/model/data.dart';
import 'package:hibye/currency.dart';
import 'package:hibye/widgets/order_item_tile.dart';
import 'package:hibye/model/user.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Hi${Provider.of<User>(context).getFirstName()}')),
      body: Column(
        children: [
          Text(
              'Amount due ${currencyString(Provider.of<Data>(context).order.total)}'),
          Container(
            height: 100.0,
            child: ListView.builder(
                itemCount: Provider.of<Data>(context).order.orderLength(),
                itemBuilder: (context, int index) {
                  return OrderItemTile(
                    index: index,
                    orderItem:
                        Provider.of<Data>(context).order.getOrderItem(index),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
