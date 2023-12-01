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
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade700,
                  Colors.blue.shade500,
                  Colors.blue.shade300,
                  Colors.blue.shade100,
                  Colors.blue.shade50,
                  Colors.white,
                  Colors.white,
                ],
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _singleBarChart(),
                  const SizedBox(height: 30),
                  _doubleBarChart(),
                  const SizedBox(height: 30),
                  _linedBarChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleBarChart() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: DoubleBarChartView(
            chartData: DoubleBarChartData(items: _singleBarChartData),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Single Bar Chart',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _doubleBarChart() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: DoubleBarChartView(
            chartData: DoubleBarChartData(items: _doubleBarChartData),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Double Bar Chart',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _linedBarChart() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: LinedBarChartView(
            chartData: LinedBarChartData(items: _chartData),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Lined Bar Chart',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

final _singleBarChartData = [
  DiagnosisChartData(
    category: 'Case1',
    earlyValue: 4.5,
    normalRangeHigh: 5.0,
    normalRangeLow: 2.0,
  ),
  DiagnosisChartData(
    category: 'Case2',
    earlyValue: 1.6,
    normalRangeHigh: 4.0,
    normalRangeLow: 2.5,
  ),
  DiagnosisChartData(
    category: 'Case3',
    earlyValue: 4.0,
    normalRangeHigh: 4.6,
    normalRangeLow: 2.1,
  ),
];

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
