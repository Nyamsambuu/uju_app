class UserModel {
  String userid;
  String userImage;
  int userpoint;

  UserModel({
    required this.userid,
    required this.userImage,
    required this.userpoint,
  });
}

class OrderState {
  int id;
  String orderdate;
  int status;
  double totalprice;
  UserAddress userAddress;
  List<OrderDetail> orderDetails;

  OrderState({
    required this.id,
    required this.orderdate,
    required this.status,
    required this.totalprice,
    required this.userAddress,
    required this.orderDetails,
  });
}

class UserAddress {
  int id;
  String? firstname;
  String? lastname;
  String? phone;
  String? phone2;
  String? regno;
  String? province;
  String? district;
  String? committee;
  String? address;

  UserAddress({
    required this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.phone2,
    this.regno,
    this.province,
    this.district,
    this.committee,
    this.address,
  });
}

class OrderDetail {
  int id;
  int itemid;
  int quantity;
  double unitprice;
  double totalprice;
  String item;

  OrderDetail({
    required this.id,
    required this.itemid,
    required this.quantity,
    required this.unitprice,
    required this.totalprice,
    required this.item,
  });
}
