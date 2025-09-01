// wallet_state.dart
class WalletState {
  final bool isLoading;
  final List<Wallet> wallets;
  final String? error;

  WalletState({
    this.isLoading = false,
    this.wallets = const [],
    this.error,
  });

  WalletState copyWith({
    bool? isLoading,
    List<Wallet>? wallets,
    String? error,
  }) {
    return WalletState(
      isLoading: isLoading ?? this.isLoading,
      wallets: wallets ?? this.wallets,
      error: error,
    );
  }
}

// wallet_model.dart
class Wallet {
  final String currency;
  final String balance;
  final String activeBalance;
  final String? depositAddress;

  Wallet({
    required this.currency,
    required this.balance,
    required this.activeBalance,
    this.depositAddress,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      currency: json['currency'],
      balance: json['balance'],
      activeBalance: json['activeBalance'],
      depositAddress: json['depositAddress'],
    );
  }
}
