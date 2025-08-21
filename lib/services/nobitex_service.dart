import 'dart:convert';
import 'package:http/http.dart' as http;

class NobitexService {
  final String baseUrl;

  NobitexService({this.baseUrl = 'https://api.nobitex.ir'});

  // Common Token auth header (old panel API keys)
  Map<String, String> _tokenHeaders(String token) => {
    'Authorization': 'Token $token',
    'Content-Type': 'application/json',
  };

  /// Validate Token by requesting wallet list
  Future<bool> validateToken(String token) async {
    final url = Uri.parse('$baseUrl/users/wallets/list/');
    final response = await http.get(url, headers: _tokenHeaders(token));
    return response.statusCode == 200;
  }

  /// Get wallet list
  Future<Map<String, dynamic>> getWalletList(String token) async {
    final url = Uri.parse('$baseUrl/users/wallets/list/');
    final response = await http.get(url, headers: _tokenHeaders(token));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch wallet list: ${response.statusCode} ${response.body}');
    }
  }

  /// Public ticker/orderbook (no auth needed)
  Future<Map<String, dynamic>> getTicker(String symbol) async {
    final url = Uri.parse('$baseUrl/v2/orderbook/$symbol');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch ticker: ${response.statusCode} ${response.body}');
    }
  }
}
