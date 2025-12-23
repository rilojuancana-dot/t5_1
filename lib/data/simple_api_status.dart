import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiStatus {
  static const String _base = 'https://acoruna.publicbikesystem.net';

  Future<Map<String, dynamic>> getPostsJson() async {
    final url = Uri.parse('$_base/customer/gbfs/v2/gl/station_status');
    
    final response = await http.get(url).timeout(
      Duration(seconds: 10), 
      onTimeout: () {
        throw Exception('Timeout al conectar con la API');
      },
    ).catchError((error) {
      throw Exception('Error al conectar con la API: $error');
    });
    
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Respuesta inesperada');
    }
    return decoded;
  }
}