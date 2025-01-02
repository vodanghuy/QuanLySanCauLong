import 'package:flutter/material.dart';
import 'dart:ui';

class PhieuDatSanPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  // Danh sách phiếu đặt sân
  final List<Map<String, dynamic>> _bookingTickets = [
    {
      'name': 'Nguyễn Văn A',
      'phone': '0901234567',
      'bookingTime': '10:00 AM',
      'court': 'Sân cầu lông 1'
    },
    {
      'name': 'Trần Thị B',
      'phone': '0907654321',
      'bookingTime': '02:00 PM',
      'court': 'Sân cầu lông 2'
    },
    // Thêm các phiếu đặt sân khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
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
                                    'Sân THN',
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
                                    'Danh sách phiếu đặt sân',
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
            // Danh sách phiếu đặt sân
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scroll của ListView để toàn bộ cuộn
              itemCount: _bookingTickets.length,
              itemBuilder: (BuildContext context, int index) {
                final ticket = _bookingTickets[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TicketDetailPage(ticket: ticket),
                    ));
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, size: 40, color: Colors.blue),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ticket['court'],
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('Người đặt: ${ticket['name']}'),
                                Text('SĐT: ${ticket['phone']}'),
                                Text('Giờ: ${ticket['bookingTime']}'),
                              ],
                            ),
                          ),
                        ],
                      ),
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

class TicketDetailPage extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const TicketDetailPage({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết phiếu đặt sân')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sân: ${ticket['court']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Người đặt: ${ticket['name']}', style: TextStyle(fontSize: 18)),
            Text('SĐT: ${ticket['phone']}', style: TextStyle(fontSize: 18)),
            Text('Giờ đặt: ${ticket['bookingTime']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logic chỉnh sửa phiếu đặt
                    print('Chỉnh sửa phiếu đặt');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white, // Đảm bảo chữ nút có màu trắng
                  ),
                  child: Text('Chỉnh sửa'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Logic xóa phiếu đặt
                    print('Xóa phiếu đặt');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white, // Đảm bảo chữ nút có màu trắng
                  ),
                  child: Text('Xóa'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
