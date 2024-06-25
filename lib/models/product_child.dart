class ProductChild {
  final int id;
  final String itemtype;
  final int salecount;
  final int quantity;
  final int? imageId;
  final double? unitprice;
  final double? discount;
  final double? calcprice;
  final String? discountend;

  ProductChild({
    required this.itemtype,
    required this.id,
    required this.salecount,
    required this.quantity,
    required this.imageId,
    required this.unitprice,
    required this.discount,
    required this.calcprice,
    this.discountend,
  });

  factory ProductChild.fromJson(Map<String, dynamic> json) {
    return ProductChild(
      id: json["id"] ?? '',
      itemtype: json['itemtype'] ?? '',
      salecount: json['salecount'] ?? 0,
      quantity: json['quantity'] ?? 0,
      imageId: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['id']
          : 0,
      unitprice: json['unitprice'],
      discount: json['price']['discount'],
      calcprice: json['price']['calcprice'],
      discountend: json['price']['discountend'],
    );
  }
}
