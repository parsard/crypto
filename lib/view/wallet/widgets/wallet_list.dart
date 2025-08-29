import 'package:flutter/material.dart';
import 'package:crypto_app/model/wallet_model.dart';
import 'wallet_card.dart';

class WalletList extends StatelessWidget {
  final List<Wallet> wallets;
  const WalletList({
    super.key,
    required this.wallets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wallets.length,
      padding: const EdgeInsets.symmetric(vertical: 12),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return AnimatedSlide(
          offset: const Offset(0, 0.1),
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 300),
            child: WalletCard(wallet: wallets[index]),
          ),
        );
      },
    );
  }
}
