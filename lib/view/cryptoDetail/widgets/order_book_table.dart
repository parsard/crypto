import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'order_book_row.dart';

class OrderBookDepthView extends StatelessWidget {
  final List<List<String>> bids;
  final List<List<String>> asks;

  const OrderBookDepthView({
    super.key,
    required this.bids,
    required this.asks,
  });

  @override
  Widget build(BuildContext context) {
    final sortedBids = [...bids]..sort((a, b) => double.parse(b[0]).compareTo(double.parse(a[0])));
    final sortedAsks = [...asks]..sort((a, b) => double.parse(a[0]).compareTo(double.parse(b[0])));
    return Column(
      children: [
        // --- Depth Chart ---
        Container(
          height: 220,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 19, 19, 42),
            borderRadius: BorderRadius.circular(12),
          ),
          child: _buildDepthChart(sortedBids, sortedAsks),
        ),
        const SizedBox(height: 16),

        // --- Order Lists ---
        Expanded(
          child: Row(
            children: [
              // Bids column
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 19, 19, 42),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView(
                    children: [
                      const Text(
                        'BIDS',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...sortedBids.take(15).map(
                            (e) => OrderBookRow(
                              price: e[0],
                              amount: e[1],
                              color: Colors.greenAccent,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Asks column
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 19, 19, 42),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView(
                    children: [
                      const Text(
                        'ASKS',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...sortedAsks.take(15).map(
                            (e) => OrderBookRow(
                              price: e[0],
                              amount: e[1],
                              color: Colors.redAccent,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDepthChart(List<List<String>> sortedBids, List<List<String>> sortedAsks) {
    final bidPoints = _toCumulativePoints(sortedBids, true);
    final askPoints = _toCumulativePoints(sortedAsks, false);

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final isBid = spot.barIndex == 0;
                return LineTooltipItem(
                  'Price: ${spot.x.toStringAsFixed(2)}'
                  'Amount: ${spot.y.toStringAsFixed(4)}',
                  TextStyle(
                    color: isBid ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
        lineBarsData: [
          // Bids
          LineChartBarData(
            spots: bidPoints,
            isCurved: true,
            color: Colors.greenAccent,
            barWidth: 2.2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                radius: 1,
                color: Colors.greenAccent,
                strokeWidth: 0,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.greenAccent.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Asks
          LineChartBarData(
            spots: askPoints,
            isCurved: true,
            color: Colors.redAccent,
            barWidth: 2.2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                radius: 1,
                color: Colors.redAccent,
                strokeWidth: 0,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _toCumulativePoints(List<List<String>> data, bool isBids) {
    final parsed = data.map((e) => [double.tryParse(e[0]) ?? 0, double.tryParse(e[1]) ?? 0]).toList();
    parsed.sort((a, b) => isBids ? b[0].compareTo(a[0]) : a[0].compareTo(b[0]));

    double total = 0;
    return [
      for (var entry in parsed.take(50)) FlSpot(entry[0], total += entry[1]),
    ];
  }
}
