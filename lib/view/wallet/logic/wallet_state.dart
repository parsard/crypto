import 'package:crypto_app/model/wallet_model.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'package:equatable/equatable.dart';

class WalletState extends Equatable {
  final NobitexService? nobitexService;
  final bool isLoading;
  final List<Wallet> wallets;
  final String? error;

  const WalletState({
    this.isLoading = false,
    this.wallets = const [],
    this.error,
    this.nobitexService
  });

  WalletState copyWith({
    NobitexService? nobitexService,
    bool? isLoading,
    List<Wallet>? wallets,
    String? error,
  }) {
    return WalletState(
      nobitexService: nobitexService ?? this.nobitexService,
      isLoading: isLoading ?? this.isLoading,
      wallets: wallets ?? this.wallets,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, wallets, error,nobitexService];
}
