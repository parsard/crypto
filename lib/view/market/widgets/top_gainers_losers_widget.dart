import 'package:crypto_app/model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class TopGainersLosersWidget extends StatelessWidget {
  final List<Crypto> gainers;
  final List<Crypto> losers;

  const TopGainersLosersWidget({
    super.key,
    required this.gainers,
    required this.losers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection("Top Gainers 🟢", gainers, Colors.greenAccent),
          SizedBox(height: 20.h),
          _buildSection("Top Losers 🔴", losers, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Crypto> items, Color changeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        ...items.map((crypto) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  /// Logo
                  CircleAvatar(
                    backgroundImage: NetworkImage(crypto.imageUrl),
                    radius: 20,
                  ),

                  SizedBox(width: 12.w),

                  /// Name & Symbol
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto.name,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          crypto.symbol.toUpperCase(),
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),

                  /// Mini chart
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 40.h,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _generatePriceSpots(crypto),
                              isCurved: true,
                              color: changeColor,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                              barWidth: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Price & Change %
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          crypto.formattedPrice,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${crypto.changePercent.toStringAsFixed(2)}%",
                          style: TextStyle(color: changeColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  /// Generates dummy line chart data (replace with real one if you have prices history)
  List<FlSpot> _generatePriceSpots(Crypto crypto) {
    final List<double> changes = [1, 1.2, 1.1, 1.4, 1.3, 1.5, 1.4];
    return List.generate(
      changes.length,
      (index) => FlSpot(index.toDouble(), changes[index]),
    );
  }
}
