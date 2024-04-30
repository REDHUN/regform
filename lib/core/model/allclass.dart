// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllClass {
  int? courseTreeId;
  String? courseType;
  String? isDeleted;
  int? courseTypesId;
  int? priorityOrder;
  String? course;
  int? parentId;
  AllClass({
    this.courseTreeId,
    this.courseType,
    this.isDeleted,
    this.courseTypesId,
    this.priorityOrder,
    this.course,
    this.parentId,
  });

  factory AllClass.fromJson(Map<String, dynamic> json) {
    return AllClass(
        course: json['course'] ?? "null",
        courseTreeId: json['courseTreeId'] ?? 0,
        courseType: json['courseType'] ?? "null",
        courseTypesId: json['courseTypesId'] ?? 0,
        isDeleted: json['isDeleted'],
        parentId: json['parentId'],
        priorityOrder: json['priorityOrder']);
  }
}
