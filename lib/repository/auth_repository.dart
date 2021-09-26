import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class AuthRepository {
  http.Client httpClient = http.Client();

  String? token;

  decodeJWT(String jwt) {
    String tokenData = jwt.split('.')[1];

    if (tokenData.length % 4 > 0) {
      tokenData +=
          '=' * (4 - tokenData.length % 4); // as suggested by Albert221
    }
    Uint8List bytes = base64.decode(tokenData);

    final data = utf8.decode(bytes, allowMalformed: true);
    final decoded = jsonDecode(data);

    return decoded;
  }

  logIn(
    String username,
    String password,
  ) async {
    final response = await httpClient.post(
      Uri.parse('https://trello.backend.tests.nekidaem.ru/api/v1/users/login/'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final token = json['token'];
      this.token = token;
      return token;
    } else {
      print(response.statusCode);
      print(response.body);
    }

    throw Exception('request failed');
  }
}
