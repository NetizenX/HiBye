import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_item_tile.dart';
import '../model/order_item.dart';

class OrderList extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      isAlwaysShown: true,
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Data>(context)
            .activeOrderRef
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: OrderItemTile(
                    index: index,
                    orderItem: OrderItem(
                      item: snapshot.data!.docs[index].get('item'),
                      price: snapshot.data!.docs[index].get('price'),
                      quantity: snapshot.data!.docs[index].get('quantity'),
                      id: snapshot.data!.docs[index].id,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
