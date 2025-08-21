import 'dart:convert';
import 'package:http/http.dart' as http;

class NobitexService {
  final String baseUrl;

  NobitexService({this.baseUrl = 'https://api.nobitex.ir'});

  /// Common headers for Token-based authentication
  Map<String, String> _tokenHeaders(String token) => {
    'Authorization': 'Token $token',
    'Content-Type': 'application/json',
  };

  /// ----------------------------
  /// Token Validation
  /// ----------------------------
  Future<bool> validateToken(String token) async {
    final url = Uri.parse('$baseUrl/users/wallets/list/');
    final response = await http.get(url, headers: _tokenHeaders(token));
    return response.statusCode == 200;
  }

  /// Fetch wallet list with Token auth
  Future<Map<String, dynamic>> getWalletList(String token) async {
    final url = Uri.parse('$baseUrl/users/wallets/list/');
    final response = await http.get(url, headers: _tokenHeaders(token));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch wallet list: ${response.statusCode} ${response.body}');
    }
  }

  /// ----------------------------
  /// Market Stats (Live Prices)
  /// ----------------------------
  Future<Map<String, dynamic>> getMarketStats({
    required String token,
    required List<String> srcCurrency,
    required List<String> dstCurrency,
  }) async {
    final url = Uri.parse('$baseUrl/market/stats');
    final response = await http.post(
      url,
      headers: _tokenHeaders(token),
      body: {'srcCurrency': srcCurrency.join(','), 'dstCurrency': dstCurrency.join(',')},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch market stats: ${response.statusCode} ${response.body}');
    }
  }

  /// ----------------------------
  /// Order Book (public or with token)
  /// ----------------------------
  Future<Map<String, dynamic>> getOrderBook(String symbol) async {
    final url = Uri.parse('$baseUrl/v2/orderbook/$symbol');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch order book: ${response.statusCode} ${response.body}');
    }
  }

  /// ----------------------------
  /// Trades (recent market trades)
  /// ----------------------------
  Future<Map<String, dynamic>> getTrades(String symbol) async {
    final url = Uri.parse('$baseUrl/v2/trades/$symbol');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch trades: ${response.statusCode} ${response.body}');
    }
  }

  /// ----------------------------
  /// Ticker shortcut (Delegates to order book)
  /// ----------------------------
  Future<Map<String, dynamic>> getTicker(String symbol) async {
    // For now, using orderbook endpoint, as before
    return getOrderBook(symbol);
  }
}
