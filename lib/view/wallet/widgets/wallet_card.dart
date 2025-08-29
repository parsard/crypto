import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_app/model/wallet_model.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  const WalletCard({super.key, required this.wallet});

  String get logoUrl =>
      'https://cryptoicons.org/api/icon/${wallet.currency.toLowerCase()}/64';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1F2E), Color(0xFF2E2E3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey[900],
          backgroundImage: NetworkImage(logoUrl),
          onBackgroundImageError: (_, __) =>
              const Icon(Icons.currency_bitcoin, color: Colors.white),
        ),
        title: Text(
          wallet.currency.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Available: ${wallet.activeBalance}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.copy, color: Colors.white),
          tooltip: 'Copy address',
          onPressed: () {
            if (wallet.depositAddress != null) {
              Clipboard.setData(
                ClipboardData(text: wallet.depositAddress!),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deposit address copied!'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
