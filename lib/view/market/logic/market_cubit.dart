import 'package:flutter_bloc/flutter_bloc.dart';
import 'market_state.dart';
import '../../../services/nobitex_service.dart';

class MarketCubit extends Cubit<MarketState> {
  final NobitexService service;
  final String token;

  MarketCubit({required this.service, required this.token}) : super(const MarketState());

  Future<void> fetchMarketStats() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final data = await service.getMarketStats(
        token: token,
        srcCurrency: ['btc', 'eth', 'usdt', 'ada', 'bnb', 'xrp', 'doge'],
        dstCurrency: ['usdt'],
      );

      final stats = data['stats'] as Map<String, dynamic>;
      final cryptos =
          stats.entries.map((entry) {
            final symbol = entry.key.toUpperCase();
            return {
              'name': _mapSymbolToName(symbol),
              'symbol': symbol,
              'price': '\$${(entry.value['bestSell'] as num).toStringAsFixed(2)}',

              'imageUrl': _cryptoLogo(symbol),
            };
          }).toList();

      emit(state.copyWith(isLoading: false, cryptos: cryptos));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
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

  static String _cryptoLogo(String symbol) {
    return 'https://cryptologos.cc/logos/${symbol.toLowerCase()}-logo.png?v=032';
  }
}
