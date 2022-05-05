import 'menu_item.dart';

class OrderItem {
  late MenuItem item;
  late int quantity;
  late double subTotal;

  OrderItem({required MenuItem item, int quantity = 1}) {
    this.item = item;
    this.quantity = quantity;
    this.subTotal = item.price * quantity;
  }

  void setQuantity(int qty) {
    quantity = qty;
    subTotal = item.price * quantity;
  }

  void increment() {
    quantity++;
    subTotal = item.price * quantity;
  }
}
