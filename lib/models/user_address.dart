class UserAddress {
  int id;
  int userid;
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
    required this.userid,
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

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'],
      userid: json['userid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      phone2: json['phone2'],
      regno: json['regno'],
      province: json['province'],
      district: json['district'],
      committee: json['committee'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'phone2': phone2,
      'regno': regno,
      'province': province,
      'district': district,
      'committee': committee,
      'address': address,
    };
  }
}
