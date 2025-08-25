import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'crypto_detail_state.dart';

class CryptoDetailCubit extends Cubit<CryptoDetailState> {
  Timer? _timer;
  CryptoDetailCubit() : super(const CryptoDetailState());

  Future<void> fetchOrderBook(String symbol, {bool showLoading = false}) async {
    if (showLoading) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      final apiSymbol = symbol.toUpperCase().endsWith('IRT') ? symbol.toUpperCase() : '${symbol.toUpperCase()}IRT';

      final res = await http.get(Uri.parse("https://apiv2.nobitex.ir/v2/depth/$apiSymbol"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        if (data['status'] != 'ok') {
          emit(state.copyWith(error: 'Invalid server response'));
          return;
        }

        emit(state.copyWith(
          isLoading: false,
          prevTradePrice: state.lastTradePrice,
          lastTradePrice: data['lastTradePrice'] ?? '',
          bids: List<List<String>>.from(
            (data['bids'] ?? []).map((e) => List<String>.from(e)),
          ),
          asks: List<List<String>>.from(
            (data['asks'] ?? []).map((e) => List<String>.from(e)),
          ),
        ));
      } else {
        emit(state.copyWith(error: 'Server error: ${res.statusCode}'));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void startAutoUpdate(String symbol) {
    emit(state.copyWith(isLoading: true));
    fetchOrderBook(symbol, showLoading: true);
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      print('Fetching order book at ${DateTime.now()}');

      fetchOrderBook(symbol);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
