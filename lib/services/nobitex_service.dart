import 'dart:convert';
import 'package:http/http.dart' as http;

class NobitexService {
  final String baseUrl;

  NobitexService({this.baseUrl = 'https://apiv2.nobitex.ir'});

  String cleanToken(String token) {
    return token.trim().replaceAll('\u0000', '');
  }

  Map<String, String> _tokenHeaders(String token) {
    return {'Authorization': 'Token ${cleanToken(token)}', 'Content-Type': 'application/json'};
  }

  // Token Validation
  Future<bool> validateToken(String token) async {
    final url = Uri.parse('$baseUrl/users/profile');
    try {
      final response = await http.get(url, headers: _tokenHeaders(token));
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getWalletList(String token) async {
    final url = Uri.parse('$baseUrl/users/wallets/list/');
    final response = await http.get(url, headers: _tokenHeaders(token));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch wallet list: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getMarketStats({
    required String token,
    required List<String> srcCurrency,
    required List<String> dstCurrency,
  }) async {
    final url = Uri.parse('$baseUrl/market/stats');
    final bodyMap = {'srcCurrency': srcCurrency.join(','), 'dstCurrency': dstCurrency.join(',')};

    final response = await http.post(
      url,
      headers: _tokenHeaders(token),
      body: jsonEncode(bodyMap), // 🔥 تغییر اصلی
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch market stats: ${response.statusCode} ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getOrderBook(String symbol) async {
    final url = Uri.parse('$baseUrl/v2/orderbook/$symbol');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch order book: ${response.statusCode} ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getTrades(String symbol) async {
    final url = Uri.parse('$baseUrl/v2/trades/$symbol');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch trades: ${response.statusCode} ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getTicker(String symbol) async {
    return getOrderBook(symbol);
  }
}
