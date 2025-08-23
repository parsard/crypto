import 'package:crypto_app/model/crypto_model.dart';
import 'package:equatable/equatable.dart';

class MarketState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<Crypto> cryptos;
  final String searchQuery;

  const MarketState({this.isLoading = false, this.error, this.cryptos = const [], this.searchQuery = ''});

  MarketState copyWith({bool? isLoading, String? error, List<Crypto>? cryptos, String? searchQuery}) {
    return MarketState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      cryptos: cryptos ?? this.cryptos,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, cryptos, searchQuery];
}
