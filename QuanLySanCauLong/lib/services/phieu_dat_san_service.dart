import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/San.dart';
import '../models/phieu_dat_san_dto.dart';

class PhieuDatSanApi {
  final String baseUrl = 'http://your_api_base_url/api/phieudatsan';

  Future<List<San>> getSans(DateTime date) async {
    final response = await http.get(Uri.parse('$baseUrl/sans?date=$date'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((san) => San.fromJson(san)).toList();
    } else {
      throw Exception('Failed to load sân');
    }
  }

  Future<void> createPhieuDatSan(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data));

    if (response.statusCode == 200) {
      print('Phiếu đặt sân đã được tạo thành công!');
    } else {
      throw Exception('Failed to create PhieuDatSan');
    }
  }
}
