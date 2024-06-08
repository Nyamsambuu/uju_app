class Valuation {
  final int id;
  final int itemId;
  final int userId;
  final int rate;
  final String comment;
  final bool isApprove;
  final DateTime updated;
  final int updatedBy;
  final String username;

  Valuation({
    required this.id,
    required this.itemId,
    required this.userId,
    required this.rate,
    required this.comment,
    required this.isApprove,
    required this.updated,
    required this.updatedBy,
    required this.username,
  });

  factory Valuation.fromJson(Map<String, dynamic> json) {
    return Valuation(
      id: json['id'] ?? 0,
      itemId: json['itemid'] ?? 0,
      userId: json['userid'] ?? 0,
      rate: (json['rate'] as num).toInt() ?? 5,
      comment: json['comment'] ?? '',
      isApprove: json['isapprove'] ?? false,
      updated: DateTime.parse(json['updated']),
      updatedBy: json['updatedby'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}
