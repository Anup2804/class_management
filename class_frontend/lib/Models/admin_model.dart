class LoginResponse {
  final AdminDetails adminDetails;
  final String generateAccessToken;
  final String generateRefreshToken;

  LoginResponse({
    required this.adminDetails,
    required this.generateAccessToken,
    required this.generateRefreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      adminDetails: AdminDetails.fromJson(json['adminDetails']),
      generateAccessToken: json['generateAccessToken'],
      generateRefreshToken: json['generateRefreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminDetails': adminDetails.toJson(),
      'generateAccessToken': generateAccessToken,
      'generateRefreshToken': generateRefreshToken,
    };
  }
}

class AdminDetails {
  final String? id;
  final String? password;
  final String adminName;
  final String email;
  final String? createdAt;
  final String? updatedAt;
  

  AdminDetails({
    this.id,
    this.password,
    required this.adminName,
    required this.email,
    this.createdAt,
    this.updatedAt,
    
  });

  factory AdminDetails.fromJson(Map<String, dynamic> json) {
    return AdminDetails(
      id: json['_id'],
      adminName: json['adminName'],
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': id,
      'adminName': adminName,
      'password':password,
      'email': email,
      // 'createdAt': createdAt,
      // 'updatedAt': updatedAt,
      
    };
  }
}
