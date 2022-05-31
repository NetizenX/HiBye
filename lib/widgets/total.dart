import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/data.dart';
import 'package:intl/intl.dart';

class Total extends StatefulWidget {
  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<Data>(context).totalStream,
        builder: (context, snapshot) {
          NumberFormat numFormat = NumberFormat('#.00', 'en_US');
          dynamic data = snapshot.data;
          double total = data['total'];
          return Text('\$${numFormat.format(total)}');
        });
  }
}
