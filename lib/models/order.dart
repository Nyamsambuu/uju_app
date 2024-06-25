class Order {
  int id;
  int itemid;
  int quantity;
  double unitprice;
  double totalprice;
  String item;

  Order({
    required this.id,
    required this.itemid,
    required this.quantity,
    required this.unitprice,
    required this.totalprice,
    required this.item,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      itemid: json['itemid'],
      quantity: json['quantity'],
      unitprice: json['unitprice'],
      totalprice: json['totalprice'],
      item: json['item'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemid': itemid,
      'quantity': quantity,
      'unitprice': unitprice,
      'totalprice': totalprice,
      'item': item,
    };
  }
}
