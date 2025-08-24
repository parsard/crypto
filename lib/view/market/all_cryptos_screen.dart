import 'package:crypto_app/view/market/logic/market_cubit.dart';
import 'package:crypto_app/view/market/logic/market_state.dart';
import 'package:crypto_app/view/market/widgets/crypto_card.dart';
import 'package:crypto_app/view/market/widgets/market_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../model/crypto_model.dart';

class AllCryptosScreen extends StatelessWidget {
  const AllCryptosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1E),
        elevation: 0,
        title: const Text(
          'All Cryptos',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar only rebuilds on searchQuery change
            Padding(
              padding: EdgeInsets.all(16.w),
              child: BlocSelector<MarketCubit, MarketState, String>(
                selector: (state) => state.searchQuery,
                builder: (context, searchQuery) {
                  return MarketSearchBar(
                    onChanged: (value) {
                      context.read<MarketCubit>().updateSearchQuery(value);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocSelector<MarketCubit, MarketState, List<Crypto>>(
                selector: (state) => state.filteredCryptos,
                builder: (context, filtered) {
                  if (filtered.isEmpty) {
                    return const Center(
                      child: Text(
                        'No assets found',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    cacheExtent: 600,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final c = filtered[index];
                      return CryptoCard(
                        key: ValueKey(c.symbol),
                        name: c.name,
                        symbol: c.symbol,
                        price: c.formattedPrice,
                        imageUrl: c.imageUrl,
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
