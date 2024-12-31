import 'package:flutter/material.dart';

class TrangChuAdmin extends StatelessWidget {
  TrangChuAdmin({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : Container(
            decoration: BoxDecoration(
              color: Colors.green, // Màu nền xanh lá cây
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 40, // Đặt kích thước cố định cho nút
              height: 40,
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white, // Icon màu trắng
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Logo",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green, // Màu nền xanh lá cây
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(
                  width: 54, // Đặt kích thước cố định cho nút
                  height: 54,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: _ProfileIcon(),
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: const Center(
          child: Text(
            "Body",
          ),
        ),
      ),
    );
  }

  Widget _drawer() => Drawer(
    child: ListView(
      children: _menuItems
          .map((item) => ListTile(
        onTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        title: Text(item),
      ))
          .toList(),
    ),
  );

  Widget _navBarItems() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: _menuItems
        .map(
          (item) => InkWell(
        onTap: () {},
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: Text(
            item,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    )
        .toList(),
  );
}

final List<String> _menuItems = <String>[
  'About',
  'Contact',
  'Cài đặt',
  'Đăng xuất',
];

enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      icon: const Icon(
        Icons.person,
        color: Colors.white, // Icon màu trắng
      ),
      offset: const Offset(0, 40),
      onSelected: (Menu item) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.itemOne,
          child: Text('Tài khoản'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemTwo,
          child: Text('Cài đặt'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemThree,
          child: Text('Đăng xuất'),
        ),
      ],
    );
  }
}
