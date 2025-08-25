import 'package:equatable/equatable.dart';

class CryptoDetailState extends Equatable {
  final bool isLoading;
  final String? error;
  final String lastTradePrice;
  final String prevTradePrice;
  final List<List<String>> bids;
  final List<List<String>> asks;

  const CryptoDetailState({
    this.isLoading = false,
    this.error,
    this.lastTradePrice = '',
    this.prevTradePrice = '',
    this.bids = const [],
    this.asks = const [],
  });

  CryptoDetailState copyWith({
    bool? isLoading,
    String? error,
    String? lastTradePrice,
    String? prevTradePrice,
    List<List<String>>? bids,
    List<List<String>>? asks,
  }) {
    return CryptoDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastTradePrice: lastTradePrice ?? this.lastTradePrice,
      prevTradePrice: prevTradePrice ?? this.prevTradePrice,
      bids: bids ?? this.bids,
      asks: asks ?? this.asks,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, lastTradePrice, bids, asks, prevTradePrice];
}
