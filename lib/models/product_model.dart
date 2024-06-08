import 'package:uju_app/models/product_valuation.dart';

class ValuationToo {
  final int rate;
  final int too;

  ValuationToo({
    required this.rate,
    required this.too,
  });

  factory ValuationToo.fromJson(Map<String, dynamic> json) {
    return ValuationToo(
      rate: (json['rate'] as num).toInt(),
      too: (json['too'] as num).toInt(),
    );
  }
}

class ProductModel {
  final int id;
  final String name;
  final List<String> productImages;
  final List<String> bodyImages;
  final List<Valuation> valuation;
  final List<ValuationToo> valuationtoo;
  final int price;
  final int? calcprice;
  final int discount;
  final int delivery;
  final String categoryname;
  final double? valuationdundaj;
  final int wishlistcount;
  final String? brandname;
  final String descbody;
  final String barcode;
  final int salecount;

  ProductModel({
    required this.id,
    required this.name,
    required this.productImages,
    required this.bodyImages,
    required this.valuation,
    required this.valuationtoo,
    required this.price,
    this.calcprice,
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
    List<Valuation> valuations = [];
    List<ValuationToo> valuationtoos = [];

    if (retdata['images'] != null) {
      for (var image in retdata['images']) {
        if (image['type'] == 1) {
          productImages.add(image['id'].toString());
        } else if (image['type'] == 2) {
          bodyImages.add(image['id'].toString());
        }
      }
    }

    if (retdata['valuation'] != null) {
      for (var val in retdata['valuation']) {
        valuations.add(Valuation.fromJson(val));
      }
    }

    if (retdata['valuationtoo'] != null) {
      for (var valToo in retdata['valuationtoo']) {
        valuationtoos.add(ValuationToo.fromJson(valToo));
      }
    }

    return ProductModel(
      id: (retdata['id'] as num).toInt(),
      name: retdata['name'] ?? '',
      productImages: productImages,
      bodyImages: bodyImages,
      valuation: valuations,
      valuationtoo: valuationtoos,
      calcprice: (priceData['calcprice'] ?? 0).toInt(),
      price: (priceData['price'] ?? 0).toInt(),
      discount: (priceData['discount'] ?? 0).toInt(),
      delivery: (retdata['delivery'] ?? 0).toInt(),
      categoryname: retdata['categoryname'] ?? '',
      valuationdundaj: retdata['valuationdundaj'] != null
          ? (retdata['valuationdundaj'] as num).toDouble()
          : 5,
      wishlistcount: (retdata['wishlistcount'] ?? 0).toInt(),
      brandname: retdata['brandname'],
      descbody: retdata['descbody'] ?? '',
      barcode: retdata['barcode'] ?? '',
      salecount: (retdata['salecount'] ?? 0).toInt(),
    );
  }
}
