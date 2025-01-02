import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String baseUrl = 'https://localhost:7092/api/auth/login';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tenDangNhap': username, 'matKhau': password}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json);
      await _saveUser(user);
      return user;
    } else {
      throw Exception('Đăng nhập thất bại');
    }
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token);
    await prefs.setString('username', user.username);
    await prefs.setString('role', user.role);

    if (user.userInfo != null) {
      await prefs.setString('email', user.userInfo!.email);
      await prefs.setString('sdt', user.userInfo!.sdt);
      await prefs.setString('gioiTinh', user.userInfo!.gioiTinh);
      await prefs.setString('hoTen', user.userInfo!.hoTen);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}
