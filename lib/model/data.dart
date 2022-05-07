import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hibye/model/menu_item.dart';
import 'order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data extends ChangeNotifier {
  Order order = Order();
  bool showOrderTray = false;
  String currentMenu = 'main';
  late DocumentReference activeOrderRef;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changeCurrentMenu(String menu) {
    currentMenu = menu;
    notifyListeners();
  }

  void addToOrder(MenuItem item) {
    activeOrderRef
        .collection('items')
        .add({'item': item.name, 'quantity': 1, 'subTotal': item.price});
    order.add(item);
    showOrderTray = true;
    notifyListeners();
  }

  void removeFromOrder({required int index}) {
    order.remove(index: index);
    if (order.orderLength() == 0) {
      showOrderTray = false;
    }
    notifyListeners();
  }

  // int menuLength() => menuItems.length;

  Future<List<MenuItem>> getMenu() async {
    List<MenuItem> menu = [];
    QuerySnapshot querySnapshot = await firestore
        .collection('menu_items')
        .where('menu', isEqualTo: currentMenu)
        .orderBy('order')
        // returns Future<QuerySnapshot<Map<String, Dynamic>>>
        .get();
    // .then((value) {return 'Hello world';});
    // List menuList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
      menu.add(MenuItem(docMap));
      // print(docMap.toString());
    }
    return menu;
  }

  void orderTest() async {
    // Search for Status == active, userID == orders, else create it
    String user = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot orderQuerySnap = await firestore
        .collection('orders')
        .where('user', isEqualTo: user)
        .where('status', isEqualTo: 'active')
        .get();
    List<QueryDocumentSnapshot> orders = orderQuerySnap.docs;
    if (orders.isNotEmpty) {
      QueryDocumentSnapshot order = orders[0];
      activeOrderRef = firestore.collection('orders').doc(order.id);
      print('found an active order for that user');
    } else {
      await firestore
          .collection('orders')
          .add({'user': user, 'status': 'active'}).then((newDoc) {
        activeOrderRef = firestore.collection('orders').doc(newDoc.id);
      });
      print('created that order');
    }
    notifyListeners();
  }

  // Future<void> loadMenu() async {
  //   for (String menuName in menuItems.keys) {
  //     for (MenuItem item in menuItems[menuName]!) {
  //       print(item.toMap());
  //       await _firestore.collection('menu_items').add(item.toMap());
  //     }
  //   }
  // }
}
