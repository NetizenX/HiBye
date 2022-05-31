import 'package:flutter/material.dart';
import '../model/data.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../widgets/order_list.dart';
import 'package:intl/intl.dart';
import '../widgets/total.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Hi${Provider.of<User>(context).getFirstName()}')),
      body: Column(
        children: [
          Total(),
          Container(height: 400.0, child: OrderList()),
          TextButton(
              onPressed: () {
                Provider.of<Data>(context, listen: false).submitOrder();
                Navigator.pop(context);
              },
              child: Text('Place Order')),
        ],
      ),
    );
  }
}
