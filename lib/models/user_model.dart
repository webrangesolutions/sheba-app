class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? profilePic;
  String? companyId;
  String? role;
  String? phoneNo;
  List? recipts;
  bool? isVerified;

  UserModel({
    this.uid,
    this.fullName,
    this.email,
    this.profilePic,
    this.companyId,
    this.role,
    this.phoneNo,
    this.recipts,
    this.isVerified,
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
    };
  }

  static UserModel? loggedinUser;
}
