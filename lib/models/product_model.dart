class ProductModel {
  final int id;
  final String name;
  final List<String> productImages;
  final List<String> bodyImages;
  final int price;
  final int discount;
  final int delivery;
  final String categoryname;
  final double? valuationdundaj; // Changed to double? for nullable double
  final int wishlistcount;
  final String? brandname; // nullable string
  final String descbody;
  final String barcode;
  final int salecount;

  ProductModel({
    required this.id,
    required this.name,
    required this.productImages,
    required this.bodyImages,
    required this.price,
    required this.discount,
    required this.delivery,
    required this.categoryname,
    this.valuationdundaj,
    required this.wishlistcount,
    this.brandname,
    required this.descbody,
    required this.barcode,
    required this.salecount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final retdata = json['retdata'] ?? {};
    final priceData = retdata['price'] ?? {};

    List<String> productImages = [];
    List<String> bodyImages = [];

    if (retdata['images'] != null) {
      for (var image in retdata['images']) {
        if (image['type'] == 1) {
          productImages.add(image['id'].toString());
        } else if (image['type'] == 2) {
          bodyImages.add(image['id'].toString());
        }
      }
    }

    return ProductModel(
      id: retdata['id'] ?? 0,
      name: retdata['name'] ?? '',
      productImages: productImages,
      bodyImages: bodyImages,
      price: (priceData['calcprice'] ?? 0).toInt(),
      discount: (priceData['discount'] ?? 0).toInt(),
      delivery: retdata['delivery'] ?? 0,
      categoryname: retdata['categoryname'] ?? '',
      valuationdundaj: retdata['valuationdundaj'] != null
          ? (retdata['valuationdundaj'] as num).toDouble()
          : null,
      wishlistcount: retdata['wishlistcount'] ?? 0,
      brandname: retdata['brandname'],
      descbody: retdata['descbody'] ?? '',
      barcode: retdata['barcode'] ?? '',
      salecount: retdata['salecount'] ?? 0,
    );
  }
}
