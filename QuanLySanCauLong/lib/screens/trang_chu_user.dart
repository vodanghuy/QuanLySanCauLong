import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class TrangChuUser extends StatefulWidget {
  const TrangChuUser({Key? key}) : super(key: key);

  @override
  State<TrangChuUser> createState() => _TrangChuUserState();
}

class _TrangChuUserState extends State<TrangChuUser> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  String? _username;
  String? _email;
  String? _phone;
  String? _gender;
  String? _hoten;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
      _email = prefs.getString('email');
      _phone = prefs.getString('phone');
      _gender = prefs.getString('gender');
      _hoten = prefs.getString('hoTen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Chiều cao AppBar
        child: AppBar(
          backgroundColor: Colors.green,
          title: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'Xin chào, $_hoten',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _authService.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
          // Màu nền AppBar
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TrangChuUser()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Đảm bảo Row không chiếm hết chiều ngang
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 50,
                        color: Colors.green,
                      ), // Icon
                      SizedBox(
                        height: 10,
                      ), // Khoảng cách giữa Icon và Text
                      Text(
                        'Đặt sân',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ), // Text
                    ],
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TrangChuUser()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Đảm bảo Row không chiếm hết chiều ngang
                    children: [
                      Icon(
                        Icons.history_edu_sharp,
                        size: 50,
                        color: Colors.orange,
                      ), // Icon
                      SizedBox(
                        height: 10,
                      ), // Khoảng cách giữa Icon và Text
                      Text(
                        'Lịch sử đặt sân',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ), // Text
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Trang chủ"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.settings),
    title: const Text("Cài đặt"),
    selectedColor: Colors.teal,
  ),
];
