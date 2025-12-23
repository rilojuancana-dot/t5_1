import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiInformation {
  static const String _base = 'https://acoruna.publicbikesystem.net';

  Future<Map<String, dynamic>> getPostsJson() async {
    debugPrint("Entrando en API Information");
    final url = Uri.parse('$_base/customer/gbfs/v2/gl/station_information');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Respuesta inesperada');
    }
        
    return decoded;
  }
}