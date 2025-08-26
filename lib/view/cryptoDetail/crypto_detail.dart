import 'package:crypto_app/view/cryptoDetail/logic/crypto_detail_cubit.dart';
import 'package:crypto_app/view/cryptoDetail/logic/crypto_detail_state.dart';
import 'package:crypto_app/view/cryptoDetail/widgets/crypto_detail_header.dart';
import 'package:crypto_app/view/cryptoDetail/widgets/order_book_table.dart';
import 'package:crypto_app/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoDetailScreen extends StatefulWidget {
  final String symbol;
  final String name;
  final String imageUrl;

  const CryptoDetailScreen({
    super.key,
    required this.symbol,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<CryptoDetailScreen> createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CryptoDetailCubit()..startAutoUpdate(widget.symbol),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F1E),
        body: SafeArea(
          child: Column(
            children: [
              /// --- Minimal Header ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// --- Content ---
              Expanded(
                child: BlocBuilder<CryptoDetailCubit, CryptoDetailState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return LoadingAnimation();
                    }

                    return Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Coin icon + price row
                          CryptoDetailHeader(
                            name: widget.name,
                            symbol: widget.symbol,
                            imageUrl: widget.imageUrl,
                            lastPrice: state.lastTradePrice,
                            prevPrice: state.prevTradePrice,
                          ),
                          SizedBox(height: 24.h),
                          Expanded(
                            child: OrderBookDepthView(
                              bids: state.bids,
                              asks: state.asks,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
