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
