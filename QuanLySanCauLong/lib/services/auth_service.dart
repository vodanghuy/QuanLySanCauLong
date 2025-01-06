import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

class AuthService {
  static const String baseUrl = 'https://localhost:7092/api/auth';

  Future<User?> login(String username, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tenDangNhap': username, 'matKhau': password}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json);
      await _saveUser(user);
      // Kiểm tra giá trị role và chuyển hướng
      if (user.role == 'User') {
        Navigator.pushReplacementNamed(context, '/home');  // Trang người dùng
      } else if (user.role == 'Admin') {
        Navigator.pushReplacementNamed(context, '/admin');  // Trang quản lý
      }
      return user;
    } else {
      throw Exception('Đăng nhập thất bại');
    }
  }

  Future<String> register(String username, String password, String hoTen, String sdt, String email, String gioiTinh) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {
              "tenDangNhap": username,
              "matKhau": password,
              "hoTen": hoTen,
              "sdt": sdt,
              "email": email,
              "gioiTinh": gioiTinh
          }),
    );

    if (response.statusCode == 200) {
      return "Đăng ký thành công";
    }
    else {
      return "Đăng ký thất bại : ${response.statusCode}";
    }
  }

  Future<bool> checkUserName(String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/checkusername?username=$username'),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.body.compareTo("true") == 0)
      {
        return true;
      }
    return false;
  }
  Future<String> checkUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/checkuser?username=$username&password=$password'),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body.toString();
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
