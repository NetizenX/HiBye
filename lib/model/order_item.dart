class OrderItem {
  late String item;
  late double price;
  late int quantity;
  late double subTotal;

  OrderItem({required String item, required double price, int quantity = 1}) {
    this.item = item;
    this.price = price;
    this.quantity = quantity;
    this.subTotal = price * quantity;
  }

  void setQuantity(int qty) {
    quantity = qty;
    subTotal = price * quantity;
  }

  void increment() {
    quantity++;
    subTotal = price * quantity;
  }
}
