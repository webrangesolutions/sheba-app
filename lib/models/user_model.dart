class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? profilePic;
  String? companyId;
  String? role;
  String? phoneNo;
  String? accessToken;
  List? recipts;
  bool? isVerified;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.companyId,
    required this.role,
    required this.phoneNo,
    required this.recipts,
    required this.isVerified,
    required this.accessToken,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullName = map["fullName"];
    email = map["email"];
    profilePic = map["profilePic"];
    companyId = map["companyId"];
    role = map["role"];
    phoneNo = map["phoneNo"];
    recipts = map["recipts"];
    isVerified = map["isVerified"];
    accessToken = map["accessToken"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "profilePic": profilePic,
      "companyId": companyId,
      "role": role,
      "phoneNo": phoneNo,
      "recipts": recipts,
      "isVerified": isVerified,
      "accessToken": accessToken,
    };
  }

  static UserModel? loggedinUser;
}
