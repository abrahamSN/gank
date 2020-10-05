import 'package:flutter/material.dart';

import 'package:spider_chart/spider_chart.dart';

class StatusChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpiderChart(
        data: [7, 5, 10, 7, 4, 7, 4],
        maxValue: 10,
        colors: [
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
        ],
        labels: <String>[
          "Jungle",
          "Mid",
          "Top",
          "AD",
          "Support",
          "Support2",
          "Support3",
        ],
      ),
    );
  }
}
