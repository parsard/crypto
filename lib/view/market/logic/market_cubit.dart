import 'package:crypto_app/model/crypto_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'market_state.dart';
import '../../../services/nobitex_service.dart';

class MarketCubit extends Cubit<MarketState> {
  final NobitexService service;
  final String token;

  MarketCubit({
    required this.service,
    required this.token,
  }) : super(const MarketState());

  Future<void> fetchMarketStats() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      // درخواست بدون محدود کردن srcCurrency
      final data = await service.getMarketStats(
        token: token,
        // اگر پارامتر رو حذف یا null کنی، همه جفت‌ها رو میاره
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
