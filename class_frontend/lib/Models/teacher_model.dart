class TeacherData {
  final TeacherDetails teacherDetails;
  final String generateAccessToken;
  final String generateRefreshToken;

  TeacherData({
    required this.teacherDetails,
    required this.generateAccessToken,
    required this.generateRefreshToken,
  });

  factory TeacherData.fromJson(Map<String, dynamic> json) {
    return TeacherData(
      teacherDetails: TeacherDetails.fromJson(json['teacherDetails']),
      generateAccessToken: json['generateAccessToken'],
      generateRefreshToken: json['generateRefreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherDetails': teacherDetails.toJson(),
      'generateAccessToken': generateAccessToken,
      'generateRefreshToken': generateRefreshToken,
    };
  }
}

class TeacherDetails {
  final String? id;
  final String fullName;
  final String adminEmail;
  final String email;
  final String? password;
  final List<String> hiredForSubject;
  final List<String> hiredForStandard;
  final List<String> hiredForBoard;
  final String staff;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TeacherDetails({
    this.id,
    required this.fullName,
    required this.adminEmail,
    required this.email,
    this.password,
    required this.hiredForSubject,
    required this.hiredForStandard,
    required this.hiredForBoard,
    required this.staff,
    this.createdAt,
    this.updatedAt,
  });

  factory TeacherDetails.fromJson(Map<String, dynamic> json) {
    return TeacherDetails(
      id: json['_id'],
      fullName: json['fullName'],
      adminEmail: json['adminEmail'],
      email: json['email'],
      hiredForSubject: List<String>.from(json['hiredForSubject']),
      hiredForStandard: List<String>.from(json['hiredForStandard']),
      hiredForBoard: List<String>.from(json['hiredForBoard']),
      staff: json['staff'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      
      'fullName': fullName,
      'adminEmail': adminEmail,
      'email': email,
      'password':password,
      'hiredForSubject': hiredForSubject,
      'hiredForStandard': hiredForStandard,
      'hiredForBoard': hiredForBoard,
      'staff': staff,
      // 'createdAt': createdAt.toIso8601String(),
      // 'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
