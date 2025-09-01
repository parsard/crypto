import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_app/view/wallet/logic/wallet_cubit.dart';
import 'package:crypto_app/view/wallet/logic/wallet_state.dart';
import 'package:crypto_app/view/wallet/widgets/wallet_tile.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<WalletCubit>();
    cubit.fetchWallets(showLoading: true);
    cubit.startAutoUpdate();
  }

  @override
  void dispose() {
    context.read<WalletCubit>().stopAutoUpdate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: SafeArea(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            // لودر کامل فقط وقتی لیست خالیه
            if (state.isLoading && state.wallets.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            // نمایش خطا اگر لیست خالی باشه
            if (state.error != null && state.wallets.isEmpty) {
              return Center(
                child: Text(state.error!, style: const TextStyle(color: Colors.red)),
              );
            }

            // نمایش داده‌ها حتی هنگام refresh
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header + لودر کوچک
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Wallets",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (state.isRefreshing)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // لیست والت‌ها
                    ListView.builder(
                      itemCount: state.wallets.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return WalletTile(wallet: state.wallets[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
