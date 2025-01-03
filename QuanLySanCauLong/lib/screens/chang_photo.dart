import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangePhotoWidget extends StatefulWidget {
  const ChangePhotoWidget({super.key});

  @override
  State<ChangePhotoWidget> createState() => _ChangePhotoWidgetState();
}

class _ChangePhotoWidgetState extends State<ChangePhotoWidget> {
  String _uploadedFileUrl =
      'https://via.placeholder.com/150'; // URL ảnh mặc định
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  // Hàm chọn ảnh từ thư viện
  Future<void> _selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thay Đổi Hình Ảnh',
          style: TextStyle(
            color: Colors.white, // Màu chữ trắng
            fontWeight: FontWeight.bold, // Chữ in đậm
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true, // Căn giữa tiêu đề
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các phần tử
          crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều ngang
          children: [
            // Hiển thị ảnh hiện tại
            CircleAvatar(
              radius: 75,
              backgroundImage: _selectedImage != null
                  ? FileImage(File(_selectedImage!.path))
                  : NetworkImage(_uploadedFileUrl) as ImageProvider,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),
            // Nút chọn ảnh
            ElevatedButton.icon(
              onPressed: _selectImage,
              icon: const Icon(Icons.image, color: Colors.white),
              label: const Text(
                'Chọn Ảnh',
                style: TextStyle(color: Colors.white), // Màu chữ trắng
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            // Nút lưu ảnh
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedImage?.path ?? _uploadedFileUrl);
              },
              child: const Text(
                'Lưu thay đổi',
                style: TextStyle(color: Colors.white), // Màu chữ trắng
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
