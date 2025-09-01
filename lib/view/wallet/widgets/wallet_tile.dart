import 'package:crypto_app/view/wallet/logic/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletTile extends StatelessWidget {
  final Wallet wallet;
  const WalletTile({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1B1B2E),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[800],
          child: Text(
            wallet.currency.toUpperCase()[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          wallet.currency.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Active: ${wallet.activeBalance}',
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Text(
          wallet.balance,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
