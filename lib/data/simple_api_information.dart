import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class ApiInformation {
  static const String _base = 'https://acoruna.publicbikesystem.net';

  Future<List<dynamic>> getPostsJson() async {
    final url = Uri.parse('$_base/customer/gbfs/v2/gl/station_information');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! List) {
      throw Exception('Respuesta inesperada');
    }
        
    return decoded;
  }
}