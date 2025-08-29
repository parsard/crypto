import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'logic/wallet_state.dart';
import 'logic/wallet_cubit.dart';
import 'widgets/wallet_list.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        
        title:  Text('My Wallets',style: TextStyle(color: Colors.white,fontSize: 28.sp,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text(state.error!, style: const TextStyle(color: Colors.red)));
          } else if (state.wallets.isEmpty) {
            return const Center(child: Text('No wallets found', style: TextStyle(color: Colors.white)));
          }

          return WalletList(wallets: state.wallets);
        },
      ),
    );
  }
}
