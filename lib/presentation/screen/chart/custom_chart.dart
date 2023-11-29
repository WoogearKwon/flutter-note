import 'package:flutter/material.dart';

import 'package:flutter_note/exports.dart';

export 'components/double_bar_charts.dart';

class CustomChartScreen extends StatelessWidget {
  const CustomChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Charts'),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.blueAccent,
                Colors.white,
                Colors.white,
              ])),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                _chartOne(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chartOne() {
    return SizedBox(
      width: double.infinity,
      child: DoubleBarChartView(
        chartData: DoubleBarChartData(items: _analysisChartData),
      ),
    );
  }
}

final _analysisChartData = [
  DiagnosisChartData(
    category: 'Case1',
    earlyValue: 4.5,
    lateValue: 4.0,
    normalRangeHigh: 5.0,
    normalRangeLow: 2.0,
  ),
  DiagnosisChartData(
    category: 'Case2',
    earlyValue: 1.6,
    lateValue: 3.1,
    normalRangeHigh: 4.0,
    normalRangeLow: 2.5,
  ),
  DiagnosisChartData(
    category: 'Case3',
    earlyValue: 4.0,
    lateValue: 3.5,
    normalRangeHigh: 4.6,
    normalRangeLow: 2.1,
  ),
];
