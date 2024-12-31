import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TrangChuUser extends StatefulWidget {
  const TrangChuUser({Key? key}) : super(key: key);

  @override
  State<TrangChuUser> createState() => _TrangChuUserState();
}

class _TrangChuUserState extends State<TrangChuUser> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Chiều cao AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), // Bo góc dưới bên trái
            bottomRight: Radius.circular(20), // Bo góc dưới bên phải
          ),
          child: AppBar(
            backgroundColor: Colors.green, // Màu nền AppBar
            title: const Text(
              'Sân cầu lông THN',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Chữ in đậm
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: _navBarItems[_selectedIndex].title,
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
    icon: const Icon(Icons.search),
    title: const Text("Tìm kiếm"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.settings),
    title: const Text("Cài đặt"),
    selectedColor: Colors.teal,
  ),
];
