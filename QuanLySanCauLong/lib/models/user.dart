import '../models/user_info.dart';
class User {
  final String username;
  final String role;
  final String token;
  final UserInfo? userInfo;

  User({
    required this.username,
    required this.role,
    required this.token,
    this.userInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['tenDangNhap'],
      role: json['role'],
      token: json['token'],
      userInfo: json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null,
    );
  }
}