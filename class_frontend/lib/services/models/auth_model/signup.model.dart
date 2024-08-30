import 'dart:convert';

class Student {
  String? id;
  String fullName;
  String adminName;
  String email;
  String password;
  String standard;
  String schoolName;
  String board;
  List<String> subjectChosen;
  String phoneNo;

  Student({
    this.id,
    required this.fullName,
    required this.adminName,
    required this.email,
    required this.standard,
    required this.password,
    required this.schoolName,
    required this.board,
    required this.subjectChosen,
    required this.phoneNo,
  });

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["_id"],
        fullName: json["fullName"],
        adminName: json["adminName"],
        email: json["email"],
        password: json["password"],
        standard: json["standard"],
        schoolName: json["schoolName"],
        board: json["board"],
        subjectChosen: List<String>.from(json["subjectChosen"].map((x) => x)),
        phoneNo: json["phoneNo"],
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "fullName": fullName,
        "adminName": adminName,
        "email": email,
        "standard": standard,
        "schoolName": schoolName,
        "password": password,
        "board": board,
        "subjectChosen": List<dynamic>.from(subjectChosen.map((x) => x)),
        "phoneNo": phoneNo,
      };

  Map<String, dynamic> toLoginJson() => {
        "email": email,
        "password": password,
      };
}
