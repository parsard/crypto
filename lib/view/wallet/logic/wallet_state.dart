// wallet_state.dart
class WalletState {
  final bool isLoading;      // لودر بزرگ برای لود اولیه
  final bool isRefreshing;   // لودر کوچک برای آپدیت پس‌زمینه
  final List<Wallet> wallets;
  final String? error;

  const WalletState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.wallets = const [],
    this.error,
  });

  WalletState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    List<Wallet>? wallets,
    String? error,
  }) {
    return WalletState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      wallets: wallets ?? this.wallets,
      error: error,
    );
  }
}

class Wallet {
  final String currency;
  final String balance;
  final String activeBalance;
  final String? depositAddress;

  const Wallet({
    required this.currency,
    required this.balance,
    required this.activeBalance,
    this.depositAddress,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      currency: json['currency'] ?? '',
      balance: json['balance'] ?? '0',
      activeBalance: json['activeBalance'] ?? '0',
      depositAddress: json['depositAddress'],
    );
  }
}
