import 'package:flutter/material.dart';

import 'package:flutter_note/exports.dart';

class LinedBarChartData {
  final List<SingleBarChartData> items;
  double _highestValue = -1;

  LinedBarChartData({
    required this.items,
  }) {
    for (SingleBarChartData item in items) {
      item.relativeValue = highestValue / item.value;
    }
  }

  double get highestValue {
    if (_highestValue != -1) {
      return _highestValue;
    }

    _highestValue = items
        .reduce((current, next) => current.value > next.value ? current : next)
        .value;
    items.firstWhere((e) => e.value == _highestValue).isHighest = true;

    return _highestValue;
  }
}

class SingleBarChartData {
  final double value;
  final String duration;
  late double _relativeValue;
  late Offset offset;
  bool isHighest = false;
  bool isSelected = false;

  SingleBarChartData({
    required this.value,
    required this.duration,
  });

  set relativeValue(value) => _relativeValue = value;

  double get relativeValue {
    return _relativeValue;
  }
}

class LinedBarChartView extends StatefulWidget {
  final LinedBarChartData chartData;
  final Color? barChartColor;
  final Color? barChartBorderColor;
  final Color? lineChartColor;
  final Color? alertChartColor;
  final Color? alertBorderColor;
  final bool Function(double value)? alertPredicate;

  const LinedBarChartView({
    Key? key,
    required this.chartData,
    this.barChartColor,
    this.barChartBorderColor,
    this.lineChartColor,
    this.alertChartColor,
    this.alertBorderColor,
    this.alertPredicate,
  }) : super(key: key);

  @override
  State<LinedBarChartView> createState() => _LinedBarChartViewState();
}

class _LinedBarChartViewState extends State<LinedBarChartView> {
  final double defaultAspectRatio = 1.72;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: defaultAspectRatio,
      child: Container(
        color: Palette.transparent,
        child: CustomPaint(
          painter: _ChartPainter(
              chartData: widget.chartData,
              lineChartColor: widget.lineChartColor ?? Palette.retroMint03Basic,
              barChartColor: widget.barChartColor ?? Palette.retroMint03Basic,
              barChartBorderColor:
              widget.barChartBorderColor ?? Palette.retroMint04Dark,
              alertChartColor: widget.alertChartColor ?? Palette.retroMint03Basic,
              alertBorderColor:
              widget.alertBorderColor ?? Palette.retroMint04Dark,
              onChartSelected: () {
                setState(() {});
              },
              alertPredicate: widget.alertPredicate),
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final LinedBarChartData chartData;
  final Color lineChartColor;
  final Color barChartColor;
  final Color barChartBorderColor;
  final Color alertChartColor;
  final Color alertBorderColor;
  final VoidCallback onChartSelected;
  final bool Function(double value)? alertPredicate;

  static const double barChartWidth = 26;
  final double tagSpaceTop = 27;
  final double durationSpaceBottom = 47;
  final double halfWidth = barChartWidth / 2;

  _ChartPainter({
    required this.chartData,
    required this.lineChartColor,
    required this.barChartColor,
    required this.barChartBorderColor,
    required this.alertChartColor,
    required this.alertBorderColor,
    required this.onChartSelected,
    this.alertPredicate,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    calculatePositionsAndPaths(canvas, size, path);

    drawMeasuringLines(canvas, size);
    drawLineChart(canvas, size, path);
    drawBarchart(canvas, size, chartData.items);
    drawBaseLine(canvas, size);
  }

  void drawMeasuringLines(Canvas canvas, Size size) {
    final height = size.height - tagSpaceTop - durationSpaceBottom;
    final lineDistance = height / 3;
    final paint = Paint()
      ..strokeWidth = 1
      ..color = Palette.greyChartLine
      ..style = PaintingStyle.stroke;

    double dy = tagSpaceTop;
    canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    dy += lineDistance;
    canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    dy += lineDistance;
    canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
  }

  void calculatePositionsAndPaths(Canvas canvas, Size size, Path path) {
    final length = chartData.items.length;
    final bool needMoreDistance = length > 3;

    final double firstX = needMoreDistance ? 35 : size.width / (length + 1);
    final distance =
    needMoreDistance ? (size.width - (firstX * 2)) / (length - 1) : firstX;
    final double maxHeight = size.height - tagSpaceTop - durationSpaceBottom;

    for (int i = 0; i < length; i++) {
      final dx = firstX + (distance * i);
      final chartHeight = maxHeight / chartData.items[i].relativeValue;
      final dy = tagSpaceTop + (maxHeight - chartHeight);

      chartData.items[i].offset = Offset(dx, dy);

      if (i == 0) {
        path.moveTo(dx, dy);
        continue;
      }

      path.lineTo(dx, dy);
    }
  }

  void drawSelectedTag(Canvas canvas, Size size, SingleBarChartData data) {
    if (!data.isSelected) {
      return;
    }

    final textSpan = TextSpan(
      text: data.value.toString(),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.right
      ..layout();

    const double rectHeight = 23;
    final rectPainter = Paint()
      ..strokeWidth = 1
      ..color = Palette.black01Basic
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(data.offset.dx, rectHeight),
      Offset(data.offset.dx, size.height - durationSpaceBottom),
      rectPainter,
    );

    rectPainter.strokeWidth = 2;
    final padding = (textPainter.width / 2) + 8;
    final rect = Rect.fromPoints(
      Offset(data.offset.dx - padding, 0),
      Offset(data.offset.dx + padding, rectHeight),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      rectPainter,
    );

    const double dy = 5;
    final textStartDx = textPainter.width / 2;
    textPainter.paint(canvas, Offset(data.offset.dx - textStartDx, dy));
  }

  void drawDuration(Canvas canvas, Size size, SingleBarChartData data) {
    final textSpan = TextSpan(
      text: data.duration,
      style: TextStyle(
        fontSize: 14,
        color: data.isSelected ? Palette.black01Basic : Palette.grey03Icon,
      ),
    );

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.right
      ..layout();

    final double dy = size.height - durationSpaceBottom + 7;
    final textStartDx = textPainter.width / 2;
    textPainter.paint(canvas, Offset(data.offset.dx - textStartDx, dy));
  }

  void drawLineChart(Canvas canvas, Size size, Path path) {
    final dashPaint = Paint()
      ..strokeWidth = 3
      ..color = lineChartColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path.toDashedPath([1, 6]), dashPaint);
  }

  void drawBarchart(Canvas canvas, Size size, List<SingleBarChartData> items) {
    final barPainter = Paint()
      ..strokeWidth = 3
      ..color = barChartBorderColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    for (final item in items) {
      drawDuration(canvas, size, item);
      drawSelectedTag(canvas, size, item);

      final isAlert = alertPredicate?.call(item.value) ?? false;
      barPainter.color = isAlert ? alertBorderColor : barChartBorderColor;

      final outerStartX = item.offset.dx - halfWidth;
      final outerStartY = size.height - durationSpaceBottom;
      final outerStartXY = Offset(outerStartX, outerStartY);
      final outerEndXY = Offset(item.offset.dx + halfWidth, item.offset.dy);
      final outerRectangle = Rect.fromPoints(outerStartXY, outerEndXY);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          outerRectangle,
          topLeft: const Radius.circular(5),
          topRight: const Radius.circular(5),
        ),
        barPainter,
      );

      barPainter.color = isAlert ? alertChartColor : barChartColor;

      const double padding = 2;
      final innerStartX = item.offset.dx - (halfWidth - padding);
      final innerStartY = size.height - durationSpaceBottom;
      final innerEndX = item.offset.dx + (halfWidth - padding);
      final innerEndY = item.offset.dy + padding;

      final innerStartXY = Offset(innerStartX, innerStartY);
      final innerEndXY = Offset(innerEndX, innerEndY);
      final innerRectangle = Rect.fromPoints(innerStartXY, innerEndXY);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          innerRectangle,
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        ),
        barPainter,
      );
    }
  }

  void drawBaseLine(Canvas canvas, Size size) {
    final dy = size.height - durationSpaceBottom;
    final paint = Paint()
      ..strokeWidth = 1
      ..color = Palette.greyChartLine
      ..style = PaintingStyle.stroke;

    paint.strokeWidth = 2;
    paint.color = Palette.black01Basic;
    canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
  }

  @override
  bool? hitTest(Offset position) {
    final dx = position.dx;
    bool isInRange = false;
    int oldIndex = chartData.items.indexWhere((element) => element.isSelected);

    for (final item in chartData.items) {
      item.isSelected = false;
    }

    for (final item in chartData.items) {
      final leftX = item.offset.dx - halfWidth;
      final rightX = item.offset.dx + halfWidth;
      isInRange = dx <= rightX && dx >= leftX;

      if (isInRange) {
        item.isSelected = true;
        onChartSelected.call();
        break;
      }
    }

    if (!isInRange && oldIndex != -1) {
      chartData.items[oldIndex].isSelected = true;
    }

    return super.hitTest(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension DashedPath on Path {
  Path toDashedPath(List<int>? dashArray) {
    if (dashArray != null) {
      final castedArray = dashArray.map((value) => value.toDouble()).toList();
      final dashedPath = dashPath(
        this,
        dashArray: CircularIntervalList<double>(castedArray),
      );

      return dashedPath;
    } else {
      return this;
    }
  }
}

Path dashPath(
    Path source, {
      required CircularIntervalList<double> dashArray,
      DashOffset? dashOffset,
    }) {
  assert(dashArray != null); // ignore: unnecessary_null_comparison

  dashOffset = dashOffset ?? const DashOffset.absolute(0);

  final dest = Path();
  for (final metric in source.computeMetrics()) {
    var distance = dashOffset._calculate(metric.length);
    var draw = true;

    while (distance < metric.length) {
      final len = dashArray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }

  return dest;
}

class CircularIntervalList<T> {
  CircularIntervalList(this._values);

  final List<T> _values;
  int _idx = 0;

  T get next {
    if (_idx >= _values.length) {
      _idx = 0;
    }
    return _values[_idx++];
  }
}

class DashOffset {
  DashOffset.percentage(double percentage)
      : _rawVal = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.percentage;

  const DashOffset.absolute(double start)
      : _rawVal = start,
        _dashOffsetType = _DashOffsetType.absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) {
    return _dashOffsetType == _DashOffsetType.absolute
        ? _rawVal
        : length * _rawVal;
  }
}

enum _DashOffsetType { absolute, percentage }
