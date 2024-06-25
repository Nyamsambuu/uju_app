import 'user_address.dart';

class OrderState {
  int id;
  int userid;
  String orderdate;
  int status;
  double totalprice;
  UserAddress userAddress;

  OrderState({
    required this.id,
    required this.userid,
    required this.orderdate,
    required this.status,
    required this.totalprice,
    required this.userAddress,
  });

  factory OrderState.fromJson(Map<String, dynamic> json) {
    return OrderState(
      id: json['id'],
      userid: json['userid'],
      orderdate: json['orderdate'],
      status: json['status'],
      totalprice: json['totalprice'],
      userAddress: UserAddress.fromJson(json['userAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'orderdate': orderdate,
      'status': status,
      'totalprice': totalprice,
      'userAddress': userAddress.toJson(),
    };
  }
}
