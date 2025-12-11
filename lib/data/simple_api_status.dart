import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiStatus {
  static const String _base = 'https://acoruna.publicbikesystem.net';

  Future<List<dynamic>> getPostsJson() async {
    final url = Uri.parse('$_base/customer/gbfs/v2/gl/station_status');
    debugPrint("ANTES DE PEDIR");

    final res = await http.get(url);
    debugPrint("DESPUES DE PEDIR");

    if (res.statusCode != 200) {
      debugPrint("STATUS ERROR CODE");
      throw Exception('HTTP ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! List) {
      debugPrint("RESPUESTA NO VALIDA");
      throw Exception('Respuesta inesperada');
    }
    debugPrint("CORRECTO");
    for (var e in decoded){
      debugPrint(e.toString());
    }
    return decoded;
  }
}