// ignore_for_file: public_member_api_docs, sort_constructors_first
class Student {
  int? academicYearId;
  String? academicYear;
  String? academicStart;
  String? academicEnd;
  int? institutionId;
  String? modifiedDate;
  //int? pageNo;
  int? rowCount;
  int? totalCount;
  String? createdBy;
  String? modifiedBy;
  int? academicId;
  bool? isDeleted;
  String? logo;
  String? institutionName;
  Student({
    this.academicYearId,
    this.academicYear,
    this.academicStart,
    this.academicEnd,
    this.institutionId,
    this.modifiedDate,
    //this.pageNo,
    this.rowCount,
    this.totalCount,
    this.createdBy,
    this.modifiedBy,
    this.academicId,
    this.isDeleted,
    this.logo,
    this.institutionName,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        academicEnd: json['academicEnd'] ?? '0',
        academicId: json['academicId'] ?? 0,
        academicStart: json['academicStart'] ?? '0',
        academicYear: json['academicYear'] ?? '0',
        academicYearId: json['academicYearId'] ?? 0,
        createdBy: json['createdBy'] ?? '0',
        institutionId: json['institutionId'] ?? 0,
        institutionName: json['institutionName'] ?? '0',
        isDeleted: json['isDeleted'] ?? true,
        logo: json['logo'] ?? '0',
        modifiedBy: json['modifiedBy'] ?? '0',
        modifiedDate: json['modifiedDate'] ?? '0',
        //  pageNo: json['pageNo'] ?? 0,
        rowCount: json['rowCount'] ?? 0,
        totalCount: json['totalCount'] ?? 0);
  }
}
