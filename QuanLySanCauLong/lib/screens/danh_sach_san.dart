import 'package:flutter/material.dart';
import 'dart:ui';

class BadmintonHomePage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  // Danh sách hình ảnh và tình trạng của từng sân
  final List<Map<String, dynamic>> _courts = [
    {
      'image': 'https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'isAvailable': true
    },
    {
      'image': 'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'isAvailable': false
    },
    {
      'image': 'https://images.pexels.com/photos/273935/pexels-photo-273935.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'isAvailable': true
    },
    {
      'image': 'https://images.pexels.com/photos/1591373/pexels-photo-1591373.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'isAvailable': false
    },
    {
      'image': 'https://images.pexels.com/photos/462024/pexels-photo-462024.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'isAvailable': true
    },
    {
      'image': 'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'isAvailable': true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView( // Thêm SingleChildScrollView để toàn bộ nội dung có thể cuộn được
        child: Column(
          children: [
            Stack(
              children: [
                ClipRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 370,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/hero_home@3x.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 370,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E2429), Color(0x001E2429)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, 1),
                      end: AlignmentDirectional(0, -1),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Image.asset(
                          'assets/images/logoUpHome@3x.png',
                          width: 230,
                          height: 90,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Xin Chào!',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sân cầu lông THN',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: AlignmentDirectional(0, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: TextFormField(
                                          controller: textController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('Search button pressed');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Text(
                                          'Tìm kiếm',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Danh sách sân
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scroll của ListView để toàn bộ cuộn
              itemCount: _courts.length,
              itemBuilder: (BuildContext context, int index) {
                final court = _courts[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SecondPage(heroTag: index, imageUrl: court['image']),
                    ));
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Hero(
                          tag: index,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              court['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sân cầu lông ${index + 1}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text(court['isAvailable'] ? 'Tình trạng: Còn trống' : 'Tình trạng: Đã đặt',
                                  style: TextStyle(color: court['isAvailable'] ? Colors.green : Colors.red)),
                            ],
                          ),
                        ),
                        // Nếu sân còn trống, hiển thị nút "Đặt sân"
                        if (court['isAvailable'])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                // Logic đặt sân
                                print('Đặt sân ${index + 1}');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'Đặt sân',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final int heroTag;
  final String imageUrl;

  const SecondPage({Key? key, required this.heroTag, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết sân cầu lông')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Thông tin chi tiết về sân cầu lông $heroTag.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
