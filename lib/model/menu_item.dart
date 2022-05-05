class MenuItem {
  // late String docID;
  late String name;
  late double price;
  late String image; // path and file name of image
  late String menu; // name of menu this is a part of
  late bool isCategory; // true if this is a link to a sub-menu
  late String
      category; // name of sub-menu clicking through links to  String name;
  late int order;

  MenuItem(Map<String, dynamic> map) {
    // this.docID = map['docID'];
    this.name = map['name'];
    this.price = map['price'];
    this.image = map['image'];
    this.menu = map['menu'];
    this.isCategory = map['isCategory'];
    this.category = map['category'];
    this.order = map['order'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> temp = Map<String, dynamic>();
    temp['name'] = name;
    temp['price'] = price;
    temp['image'] = image;
    temp['menu'] = menu;
    temp['isCategory'] = isCategory;
    temp['category'] = category;
    return temp;
  }
}
