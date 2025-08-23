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
    // Return if already loading to prevent duplicate calls
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final data = await service.getMarketStats(
        token: token,
        srcCurrency: ['btc', 'eth', 'usdt', 'ada', 'bnb', 'xrp', 'doge'],
        dstCurrency: ['usdt'],
      );

      final stats = data['stats'] as Map<String, dynamic>;

      // Map the API response to a list of Crypto objects
      final List<Crypto> cryptos = stats.entries.map((entry) {
        // Correctly extract the base symbol, e.g., 'btc' from 'btc-usdt'
        final String baseSymbol = entry.key.split('-').first.toUpperCase();

        // Safely parse the price to a double
        final double price = double.tryParse(
              entry.value['bestSell'].toString(),
            ) ??
            0.0;

        // Create an instance of the Crypto model
        return Crypto(
          name: _mapSymbolToName(baseSymbol),
          symbol: baseSymbol,
          price: price, // Pass the double, not a formatted string
          imageUrl: _getLogoUrl(baseSymbol),
        );
      }).toList();

      emit(
        state.copyWith(isLoading: false, cryptos: cryptos),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: e.toString()),
      );
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  // Helper function to map symbol to a readable name
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

  // Helper function to get a reliable logo URL
  static String _getLogoUrl(String symbol) {
    // Using a more reliable source for cryptocurrency icons
    return 'https://raw.githubusercontent.com/atomiclabs/cryptocurrency-icons/master/128/color/${symbol.toLowerCase()}.png';
  }
}
