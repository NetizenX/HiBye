import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hibye/constants.dart';
import 'package:hibye/currency.dart';
import 'package:hibye/model/data.dart';
import 'order_item_tile.dart';
import 'package:hibye/screens/payment_screen.dart';
import 'package:hibye/screen_size.dart';

class OrderTray extends StatelessWidget {
  // const OrderTray({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: Provider.of<Data>(context, listen: false).showOrderTray
          ? screenHeight(context) * 0.25
          : 0.0,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
          color: kPopOverColor,
          borderRadius: BorderRadius.only(
            topLeft: kRadius,
            topRight: kRadius,
          )),
      child: Column(
        children: [
          Text(
            'Your Order',
            style: kSectionTitleSyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight(context) * 0.15,
                width: screenWidth(context) * 0.6,
                child: Scrollbar(
                  controller: _scrollController,
                  isAlwaysShown: true,
                  child: ListView.builder(
                      itemCount: Provider.of<Data>(context).order.orderLength(),
                      itemBuilder: (context, int index) {
                        return Card(
                          child: OrderItemTile(
                            index: index,
                            orderItem: Provider.of<Data>(context)
                                .order
                                .getOrderItem(index),
                          ),
                        );
                      }),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(20.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'pay',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(currencyString(
                        Provider.of<Data>(context, listen: false).order.total)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
