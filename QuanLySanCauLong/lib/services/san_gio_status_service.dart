import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/san_gio.dart';

class SanGioApi {
  static const String baseUrl = 'http://yourapiurl/api/phieudatsan/getSanGioByDate';

  static Future<List<SanGio>> fetchSanGioByDate(DateTime date) async {
    final response = await http.get(Uri.parse('$baseUrl/${date.toIso8601String()}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => SanGio.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
