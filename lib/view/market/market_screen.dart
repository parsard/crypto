import 'package:crypto_app/model/crypto_model.dart';
import 'package:crypto_app/view/cryptoDetail/crypto_detail.dart';
import 'package:crypto_app/view/market/all_cryptos_screen.dart';
import 'package:crypto_app/view/market/logic/market_cubit.dart';
import 'package:crypto_app/view/market/logic/market_state.dart';
import 'package:crypto_app/view/market/widgets/crypto_card.dart';
import 'package:crypto_app/view/market/widgets/section_title.dart';
import 'package:crypto_app/view/profile/profile_screen.dart';
import 'package:crypto_app/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MarketCubit>().startAutoUpdate();
  }

  @override
  void dispose() {
    context.read<MarketCubit>().stopAutoUpdate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: SafeArea(
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, state) {
            if (state.isLoading && state.cryptos.isEmpty) {
              return LoadingAnimation();
            }

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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreenWrapper()));
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  SizedBox(height: 16.h),

                  /// --- Crypto Row ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SectionTitle(
                      title: "Top Cryptos",
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<MarketCubit>(),
                              child: const AllCryptosScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  SizedBox(
                    height: 160.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.topCryptos.length,
                      itemBuilder: (context, index) {
                        final Crypto c = state.cryptos[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: CryptoCard(
                            name: c.name,
                            symbol: c.symbol,
                            price: c.formattedPrice,
                            imageUrl: c.imageUrl,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          CryptoDetailScreen(symbol: c.symbol, name: c.name, imageUrl: c.imageUrl)));
                            },
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
