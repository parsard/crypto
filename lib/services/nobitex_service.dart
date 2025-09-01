import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef LogoutCallback = Future<void> Function({String? error});

class NobitexService {
  final String baseUrl;
  final LogoutCallback? onUnauthorized;

  NobitexService({this.baseUrl = 'https://apiv2.nobitex.ir', this.onUnauthorized});

  String cleanToken(String token) {
    return token.trim().replaceAll('\u0000', '');
  }

  Map<String, String> tokenHeaders(String token) {
    return {'Authorization': 'Token ${cleanToken(token)}', 'Content-Type': 'application/json'};
  }

  Future<http.Response> sendRequest(Future<http.Response> Function() requestFunction, {String? token}) async {
    try {
      final response = await requestFunction();
      if (response.statusCode == 401) {
        debugPrint('Unauthorized access: 401 received. Attempting to log out.');
        await onUnauthorized?.call(error: 'Your API key is invalid or has expired. Please re-enter.');

        throw Exception('Unauthorized: Token is invalid or expired.');
      }
      return response;
    } on Exception catch (e) {
      debugPrint('Error in _sendRequest: $e');
      rethrow;
    }
  }

  // Token Validation
  Future<bool> validateToken(String token) async {
    final url = Uri.parse('$baseUrl/users/profile');
    try {
      final response = await sendRequest(
        () => http.get(url, headers: tokenHeaders(token)),
      );
      return response.statusCode == 200;
    } on Exception catch (e) {
      if (e.toString().contains('Unauthorized')) {
        return false;
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getWalletList(String token) async {
    final url = Uri.parse('$baseUrl/users/wallets/list/');
    final response = await http.get(url, headers: tokenHeaders(token));
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
      headers: tokenHeaders(token),
      body: jsonEncode(bodyMap),
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

  Future<void> logout(String token) async {
    final url = Uri.parse('$baseUrl/auth/logout/');
    final response = await http.post(url, headers: tokenHeaders(token));
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw Exception('Failed to logout: ${response.statusCode} ${response.body}');
    }
  }
}
