import 'package:flutter/material.dart';
import 'dart:ui';

class CourtBookingPage extends StatefulWidget {
  final int courtIndex;
  final String courtImageUrl;

  CourtBookingPage({required this.courtIndex, required this.courtImageUrl});

  @override
  _CourtBookingPageState createState() => _CourtBookingPageState();
}

class _CourtBookingPageState extends State<CourtBookingPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Biến lưu giá trị thời gian được chọn
  String? selectedTime;

  // Danh sách thời gian có thể chọn
  final List<String> availableTimes = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đặt sân ${widget.courtIndex + 1}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.courtIndex,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.courtImageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nhập thông tin để đặt sân',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Họ và tên'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Số điện thoại'),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Thời gian đặt sân'),
              value: selectedTime,
              items: availableTimes.map((time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTime = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Vui lòng chọn thời gian đặt sân!')),
                  );
                  return;
                }

                final name = nameController.text;
                final phone = phoneController.text;

                // Ví dụ: In thông tin đã nhập
                print('Đặt sân ${widget.courtIndex + 1} - Thông tin:');
                print('Tên: $name');
                print('Số điện thoại: $phone');
                print('Thời gian: $selectedTime');

                // Thực hiện logic lưu thông tin và đặt sân
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đặt sân thành công!')));
                Navigator.of(context).pop(); // Quay lại trang trước
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Xác nhận Đặt sân'),
            ),
          ],
        ),
      ),
    );
  }
}
