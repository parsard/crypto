import 'package:crypto_app/model/crypto_model.dart';
import 'package:equatable/equatable.dart';

class MarketState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<Crypto> cryptos;
  final String searchQuery;
  final List<Crypto> allCryptos;
  final List<Crypto> topCryptos;
  final List<Crypto> filteredCryptos;

  const MarketState({
    this.isLoading = false,
    this.error,
    this.cryptos = const [],
    this.searchQuery = '',
    this.allCryptos = const [],
    this.topCryptos = const [],
    this.filteredCryptos = const [],
  });

  MarketState copyWith(
      {bool? isLoading,
      List<Crypto>? allCryptos,
      List<Crypto>? topCryptos,
      List<Crypto>? filteredCryptos,
      String? error,
      List<Crypto>? cryptos,
      String? searchQuery}) {
    return MarketState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      cryptos: cryptos ?? this.cryptos,
      searchQuery: searchQuery ?? this.searchQuery,
      allCryptos: allCryptos ?? this.allCryptos,
      topCryptos: topCryptos ?? this.topCryptos,
      filteredCryptos: filteredCryptos ?? this.filteredCryptos,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, cryptos, searchQuery];
}
