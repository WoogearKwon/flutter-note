import 'package:flutter/material.dart';

import 'package:flutter_note/exports.dart';

export 'components/double_bar_charts.dart';
export 'components/lined_bar_chart.dart';

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
                _doubleBarChart(),
                const SizedBox(height: 20),
                _linedBarChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doubleBarChart() {
    return SizedBox(
      width: double.infinity,
      child: DoubleBarChartView(
        chartData: DoubleBarChartData(items: _doubleBarChartData),
      ),
    );
  }

  Widget _linedBarChart() {
    return SizedBox(
      width: double.infinity,
      child: LinedBarChartView(
        chartData: LinedBarChartData(items: _chartData),
      ),
    );
  }
}

final _doubleBarChartData = [
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

final _chartData = [
  SingleBarChartData(
    value: 8,
    duration: "09.16\n-09.22",
  ),
  SingleBarChartData(
    value: 7,
    duration: "09.16\n-09.22",
  ),
  SingleBarChartData(
    value: 5,
    duration: "09.16\n-09.22",
  ),
  SingleBarChartData(
    value: 13,
    duration: "09.16\n-09.22",
  ),
];
