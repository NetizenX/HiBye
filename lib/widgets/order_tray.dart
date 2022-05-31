import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/payment_screen.dart';
import '../screen_size.dart';
import 'order_list.dart';
import '../widgets/total.dart';

class OrderTray extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Removed slide-in function, now always shown - NX
    // return AnimatedContainer(
    //   duration: Duration(milliseconds: 500),
    //   height: Provider.of<Data>(context, listen: false).showOrderTray
    //       ? screenHeight(context) * 0.25
    //       : 0.0,
    return Container(
      height: screenHeight(context) * 0.25,
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
                child: OrderList(),
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
                    // Order total
                    Total(),
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
