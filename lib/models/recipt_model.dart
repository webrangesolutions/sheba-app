class ReciptModel {
  String? reciptId;
  String? userId;
  String? merchant;
  String? createdAt;
  String? curency;
  String? totalBill;
  String? description;
  String? category;
  String? paymentMethod;
  String? image;

  ReciptModel({
    required this.reciptId,
    required this.userId,
    required this.merchant,
    required this.createdAt,
    required this.curency,
    required this.totalBill,
    required this.description,
    required this.category,
    required this.paymentMethod,
    required this.image,
  });

  ReciptModel.fromMap(Map<String, dynamic> map) {
    reciptId = map["reciptId"];
    userId = map["userId"];
    merchant = map["merchant"];
    createdAt = map["createdAt"];
    curency = map["curency"];
    totalBill = map["totalBill"];
    description = map["description"];
    category = map["category"];
    paymentMethod = map["paymentMethod"];
    image = map["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "reciptId": reciptId,
      "userId": userId,
      "merchant": merchant,
      "createdAt": createdAt,
      "curency": curency,
      "totalBill": totalBill,
      "description": description,
      "category": category,
      "paymentMethod": paymentMethod,
      "image": image,
    };
  }
}
