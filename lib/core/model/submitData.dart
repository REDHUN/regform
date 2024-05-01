class submitData {
  String? userId;
  int? institutionId;
  String? name;
  String? userCode;
  String? address;
  String? emailId;
  String? mobileCode;
  String? whatsappCode;
  String? mobileNo;
  String? whatsappNo;
  String? image;
  String? password;
  String? userType;
  String? academicYearId;
  String? createdBy;
  String? modifiedBy;
  List<UserClassDetailsList>? userClassDetailsList;
  String? areaofintrest;

  submitData(
      {this.userId,
      this.institutionId,
      this.name,
      this.userCode,
      this.address,
      this.emailId,
      this.mobileCode,
      this.whatsappCode,
      this.mobileNo,
      this.whatsappNo,
      this.image,
      this.password,
      this.userType,
      this.academicYearId,
      this.createdBy,
      this.modifiedBy,
      this.userClassDetailsList,
      this.areaofintrest});

  submitData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    institutionId = json['institutionId'];
    name = json['name'];
    userCode = json['userCode'];
    address = json['address'];
    emailId = json['emailId'];
    mobileCode = json['mobileCode'];
    whatsappCode = json['whatsappCode'];
    mobileNo = json['mobileNo'];
    whatsappNo = json['whatsappNo'];
    image = json['image'];
    password = json['password'];
    userType = json['userType'];
    academicYearId = json['academicYearId'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    if (json['userClassDetailsList'] != null) {
      userClassDetailsList = <UserClassDetailsList>[];
      json['userClassDetailsList'].forEach((v) {
        userClassDetailsList!.add(new UserClassDetailsList.fromJson(v));
      });
    }
    areaofintrest = json['areaofintrest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['institutionId'] = this.institutionId;
    data['name'] = this.name;
    data['userCode'] = this.userCode;
    data['address'] = this.address;
    data['emailId'] = this.emailId;
    data['mobileCode'] = this.mobileCode;
    data['whatsappCode'] = this.whatsappCode;
    data['mobileNo'] = this.mobileNo;
    data['whatsappNo'] = this.whatsappNo;
    data['image'] = this.image;
    data['password'] = this.password;
    data['userType'] = this.userType;
    data['academicYearId'] = this.academicYearId;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    if (this.userClassDetailsList != null) {
      data['userClassDetailsList'] =
          this.userClassDetailsList!.map((v) => v.toJson()).toList();
    }
    data['areaofintrest'] = this.areaofintrest;
    return data;
  }
}

class UserClassDetailsList {
  int? userClassId;
  String? userId;
  String? classId;

  UserClassDetailsList({this.userClassId, this.userId, this.classId});

  UserClassDetailsList.fromJson(Map<String, dynamic> json) {
    userClassId = json['userClassId'];
    userId = json['userId'];
    classId = json['classId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userClassId'] = this.userClassId;
    data['userId'] = this.userId;
    data['classId'] = this.classId;
    return data;
  }
}
