// This is the student model.

class StudentDetails {
  final String? id;
  final String fullName;
  final String adminEmail;
  final String email;
  final String? password;
  final String standard;
  final String schoolName;
  final String board;
  final List<String> subjectChosen;
  final String phoneNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  

  StudentDetails({
    this.id,
    required this.fullName,
    required this.adminEmail,
    required this.email,
    this.password,
    required this.standard,
    required this.schoolName,
    required this.board,
    required this.subjectChosen,
    required this.phoneNo,
    this.createdAt,
    this.updatedAt,
    
  });

  factory StudentDetails.fromJson(Map<String, dynamic> json) {
    return StudentDetails(
      id: json['_id'],
      fullName: json['fullName'],
      adminEmail: json['adminEmail'],
      email: json['email'],
      standard: json['standard'],
      schoolName: json['schoolName'],
      board: json['board'],
      subjectChosen: List<String>.from(json['subjectChosen']),
      phoneNo: json['phoneNo'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': id,
      'fullName': fullName,
      'adminEmail': adminEmail,
      'email': email,
      'password':password,
      'standard': standard,
      'schoolName': schoolName,
      'board': board,
      'subjectChosen': subjectChosen,
      'phoneNo': phoneNo,
      // 'createdAt': createdAt.toIso8601String(),
      // 'updatedAt': updatedAt.toIso8601String(),
      
    };
  }
}

// class LoginResponse {
//   final StudentDetails studentDetails;
//   final String accessToken;
//   final String refreshToken;

//   LoginResponse({
//     required this.studentDetails,
//     required this.accessToken,
//     required this.refreshToken,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       studentDetails: StudentDetails.fromJson(json['sutdentDetails']),
//       accessToken: json['generateAccessToken'],
//       refreshToken: json['generateRefreshToken'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'sutdentDetails': studentDetails.toJson(),
//       'generateAccessToken': accessToken,
//       'generateRefreshToken': refreshToken,
//     };
//   }
// }
