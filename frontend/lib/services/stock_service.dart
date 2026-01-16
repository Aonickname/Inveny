import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StockService {
  // 서버의 기본 주소예요.
  final String baseUrl = dotenv.env['BASE_URL'] ?? "주소 찾지 못했어요";

  // 1. 모든 재고 가져오기 (GET)
  Future<List<Stock>> fetchStocks() async {
    final response = await http.get(Uri.parse(baseUrl));
    
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((item) => Stock.fromJson(item)).toList();
    } else {
      throw Exception('서버에서 데이터를 가져오지 못했어요.');
    }
  }

  // 2. 수량만 살짝 수정하기 (PATCH)
  Future<void> updateStockQuantity(int id, int newQuantity) async {
    await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"quantity": newQuantity}),
    );
  }

  // 3. [추가] 재고 정보 전체 수정하기 (PUT)
  // 이름, 카테고리, 수량을 한꺼번에 상자에 담아서 서버에 보내요.
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

  // 4. [추가] 재고 삭제하기 (DELETE)
  // 번호(id)를 알려주면 서버에 가서 그 번호를 지우라고 말해요.
  Future<void> deleteStock(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    // 200(성공)이나 204(내용 없음)면 잘 지워진 거예요.
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('삭제에 실패했습니다.');
    }
  }

  // 5. 새로운 재고 추가하기 (POST)
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