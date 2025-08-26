import 'dart:async';

import 'package:crypto_app/model/crypto_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'market_state.dart';
import '../../../services/nobitex_service.dart';

class MarketCubit extends Cubit<MarketState> {
  final NobitexService service;
  final String token;
  Timer? _timer;

  MarketCubit({
    required this.service,
    required this.token,
  }) : super(const MarketState());

  void startAutoUpdate({Duration interval = const Duration(seconds: 5)}) {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(interval, (_) {
      fetchMarketStats(showLoading: false);
    });
  }

  void stopAutoUpdate() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> fetchMarketStats({bool showLoading = true}) async {
    if (state.isLoading && showLoading) return;

    emit(state.copyWith(isLoading: showLoading, error: null));

    try {
      final data = await service.getMarketStats(
        token: token,
        srcCurrency: [],
        dstCurrency: ['usdt'],
      );

      final stats = data['stats'] as Map<String, dynamic>;

      final List<Crypto> all = stats.entries.map((entry) {
        final String baseSymbol = entry.key.split('-').first.toUpperCase();
        final double price = double.tryParse(
              entry.value['bestSell'].toString(),
            ) ??
            0.0;

        return Crypto(
          name: _mapSymbolToName(baseSymbol),
          symbol: baseSymbol,
          price: price,
          imageUrl: _getLogoUrl(baseSymbol),
        );
      }).toList();
      final List<Crypto> sortedByPrice = List.from(all)..sort((a, b) => b.price.compareTo(a.price));

      final debugTop = sortedByPrice.take(3).map((c) => "${c.symbol}: ${c.price}").join(" | ");
      final now = DateTime.now().toIso8601String();

      print("[$now] Market data refreshed -> $debugTop");

      emit(state.copyWith(
        isLoading: false,
        cryptos: sortedByPrice.take(6).toList(),
        allCryptos: all,
        topCryptos: sortedByPrice.take(6).toList(),
        filteredCryptos: all,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    stopAutoUpdate();
    return super.close();
  }

  void updateSearchQuery(String query) {
    final filtered = state.allCryptos.where((c) {
      final q = query.toLowerCase();
      return c.name.toLowerCase().contains(q) || c.symbol.toLowerCase().contains(q);
    }).toList();

    emit(state.copyWith(searchQuery: query, filteredCryptos: filtered));
  }

  static String _mapSymbolToName(String symbol) {
    switch (symbol) {
      case 'BTC':
        return 'Bitcoin';
      case 'ETH':
        return 'Ethereum';
      case 'USDT':
        return 'Tether';
      case 'ADA':
        return 'Cardano';
      case 'BNB':
        return 'Binance Coin';
      case 'XRP':
        return 'Ripple';
      case 'DOGE':
        return 'Dogecoin';
      default:
        return symbol;
    }
  }

  static String _getLogoUrl(String symbol) {
    return 'https://raw.githubusercontent.com/atomiclabs/cryptocurrency-icons/master/128/color/${symbol.toLowerCase()}.png';
  }
}
