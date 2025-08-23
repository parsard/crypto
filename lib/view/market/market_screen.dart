import 'package:crypto_app/model/crypto_model.dart';
import 'package:crypto_app/view/market/logic/market_cubit.dart';
import 'package:crypto_app/view/market/logic/market_state.dart';
import 'package:crypto_app/view/market/widgets/crypto_card.dart';
import 'package:crypto_app/view/market/widgets/crypto_suggestion.dart';
import 'package:crypto_app/view/market/widgets/market_search_bar.dart';
import 'package:crypto_app/view/market/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: SafeArea(
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, state) {
            // This logic remains unchanged
            if (state.isLoading && state.cryptos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }

            // Filter logic updated to use object properties
            final List<Crypto> suggestions = state.cryptos.where((c) {
              final query = state.searchQuery.toLowerCase();
              return c.name.toLowerCase().contains(query) || // <-- CHANGED
                  c.symbol.toLowerCase().contains(query); // <-- CHANGED
            }).toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- Header ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Market",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  /// --- Search Bar ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: MarketSearchBar(
                      onChanged: (value) {
                        context.read<MarketCubit>().updateSearchQuery(value);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// --- Suggestions ---
                  if (state.searchQuery.isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xFF1A1A27),
                      ),
                      child: Column(
                        children: suggestions.isNotEmpty
                            ? suggestions
                                .map(
                                  (c) => CryptoSuggestion(
                                    name: c.name, // <-- CHANGED
                                    symbol: c.symbol, // <-- CHANGED
                                    onTap: () {
                                      // navigate to detail
                                    },
                                  ),
                                )
                                .toList()
                            : [
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    'No matches found',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                              ],
                      ),
                    ),

                  SizedBox(height: 16.h),

                  /// --- Crypto Row ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SectionTitle(
                      title: "Top Cryptos",
                      onSeeAll: () {},
                    ),
                  ),
                  SizedBox(height: 12.h),

                  SizedBox(
                    height: 160.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.cryptos.length,
                      itemBuilder: (context, index) {
                        final Crypto c = state.cryptos[index]; // <-- Type is now Crypto
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: CryptoCard(
                            name: c.name, // <-- CHANGED
                            symbol: c.symbol, // <-- CHANGED
                            price: c.formattedPrice, // <-- CHANGED & USING GETTER!
                            imageUrl: c.imageUrl, // <-- CHANGED
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
