import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<bool> login(String loginId, String password) async {
  
    print("보내는 주소: $baseUrl/users/login");

    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "loginId": loginId,
        "password": password,
      }),
    );

    return response.statusCode == 200;
  }
}