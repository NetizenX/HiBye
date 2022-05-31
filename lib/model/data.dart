import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'item_on_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data extends ChangeNotifier {
  // Order order = Order();
  double total = 0.0;
  String currentMenu = 'main';
  late DocumentReference activeOrderRef;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream totalStream;

  void changeCurrentMenu(String menu) {
    currentMenu = menu;
    notifyListeners();
  }

  void updateTotal(double amount) async {
    DocumentSnapshot docSnap = await activeOrderRef.get();
    Map<String, dynamic> docData = docSnap.data()! as Map<String, dynamic>;
    double currentTotal = docData['total'];
    currentTotal += amount;
    activeOrderRef.update({'total': currentTotal});
  }

  void addToOrder(ItemOnMenu item) async {
    //TODO: Check for existing item and add quantity
    activeOrderRef
        .collection('items')
        .add({'item': item.name, 'quantity': 1, 'price': item.price});
    updateTotal(item.price);
    // order.add(item);
    // notifyListeners();
  }

  void removeFromOrder({required String id, required double price}) {
    activeOrderRef.collection('items').doc(id).delete();
    updateTotal(-price);
    // notifyListeners();
  }

  Future<List<ItemOnMenu>> getMenu() async {
    List<ItemOnMenu> menu = [];
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
      menu.add(ItemOnMenu(docMap));
      // print(docMap.toString());
    }
    return menu;
  }

  void initializeOrder() async {
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
          .add({'user': user, 'status': 'active', 'total': 0.0}).then((newDoc) {
        activeOrderRef = firestore.collection('orders').doc(newDoc.id);
      });
      print('created that order');
    }
    // Setup the stream used to display the order total
    totalStream = activeOrderRef.snapshots();
    notifyListeners();
  }

  void submitOrder() {
    activeOrderRef.update({'status': 'submitted'});
    initializeOrder();
    // notifyListeners();
  }

  void orderTest() async {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference collectionRef = firestore.collection('orders');
    // DocumentReference docRef = collectionRef.doc('OyaA66XkTFG9rsNGNtzr');
    // DocumentSnapshot snapshot = await docRef.get();
    // Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    // double price = data['total'];
    DocumentSnapshot orderSnap = await activeOrderRef.get();
    dynamic data = orderSnap.data();
    double price = data['total'];
    print(price);
  }
}
