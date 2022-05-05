import 'order_item.dart';
import 'menu_item.dart';

class Order {
  List<OrderItem> items = [];
  double total = 0.0;

  void calculateTotal() {
    total = 0.0;
    for (OrderItem orderItem in items) {
      total += orderItem.subTotal;
    }
  }

  void add(MenuItem menuItem) {
    for (OrderItem orderItem in items) {
      // if the item is already on the order, just increase the quantity
      if (orderItem.item == menuItem) {
        orderItem.increment();
        orderItem.subTotal = orderItem.item.price * orderItem.quantity;
        calculateTotal();
        return;
      }
    }
    // not in order, add it
    items.add(OrderItem(item: menuItem));
    calculateTotal();
  }

  void remove({required int index}) {
    if (index >= 0 && index < orderLength()) {
      items.removeAt(index);
      calculateTotal();
    }
  }

  int orderLength() => items.length;

  OrderItem? getOrderItem(int index) {
    if (index >= 0 && index < orderLength()) {
      return items[index];
    }
  }
}
