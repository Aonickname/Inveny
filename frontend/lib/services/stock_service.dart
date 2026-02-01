import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StockService {
  final String baseUrl = (dotenv.env['BASE_URL'] ?? "주소 찾지 못했어요") + "/stocks";



  Future<List<Stock>> fetchStocks() async {
    final response = await http.get(Uri.parse(baseUrl));


    
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((item) => Stock.fromJson(item)).toList();
    } else {
      throw Exception('서버에서 데이터를 가져오지 못했어요.');
    }
  }

  Future<void> updateStockQuantity(int id, int newQuantity) async {
    await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"quantity": newQuantity}),
    );
  }

  Future<void> updateStock(int id, String name, String category, int quantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "category": category,
        "quantity": quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('수정에 실패했습니다.');
    }
  }

  Future<void> deleteStock(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('삭제에 실패했습니다.');
    }
  }

  Future<void> createStock(String name, int quantity, String unit, String category, String location, String memo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "quantity": quantity,
        "unit": unit,
        "category": category,
        "location": location,
        "memo": memo,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('등록에 실패했습니다.');
    }
  }
}