class OrderItem {
  late String item;
  late double price;
  late int quantity;
  late double subTotal;
  late String id;

  OrderItem(
      {required String item,
      required double price,
      int quantity = 1,
      required String id}) {
    this.item = item;
    this.price = price;
    this.quantity = quantity;
    this.subTotal = price * quantity;
    this.id = id;
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
