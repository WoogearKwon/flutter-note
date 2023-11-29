import 'package:flutter/material.dart';

import 'package:flutter_note/exports.dart';

class DoubleBarChartData {
  final List<DiagnosisChartData> items;

  DoubleBarChartData({required this.items});
}

class DiagnosisChartData {
  final String category;
  final double earlyValue;
  final double? lateValue;
  final double normalRangeHigh;
  final double normalRangeLow;

  Offset normalStartOffset = Offset.zero;
  Offset normalEndOffset = Offset.zero;

  double get centerX => (normalStartOffset.dx + normalEndOffset.dx) / 2;

  DiagnosisChartData({
    required this.category,
    required this.earlyValue,
    this.lateValue,
    required this.normalRangeHigh,
    required this.normalRangeLow,
  });
}

class DoubleBarChartView extends StatelessWidget {
  final DoubleBarChartData chartData;
  final double singleChartRatio = 1.92;
  final double doubleChartRatio = 1.42;

  const DoubleBarChartView({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasLateValues = _hasLateDiagnosis();

    return AspectRatio(
      aspectRatio: hasLateValues ? doubleChartRatio : singleChartRatio,
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 17,
          left: 18,
          right: 21,
        ),
        decoration: BoxDecoration(
            color: Palette.grey01Bg, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            const _NormalRangeIndicator(),
            _ChartView(data: chartData.items),
            if (hasLateValues) const _DiagnosisCategoryGuide(),
          ],
        ),
      ),
    );
  }

  bool _hasLateDiagnosis() {
    bool hasLateValues = false;

    for (final data in chartData.items) {
      if (data.lateValue != null) {
        return true;
      }
    }

    return hasLateValues;
  }
}

class _ChartView extends StatelessWidget {
  final List<DiagnosisChartData> data;

  const _ChartView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 3),
        child: LayoutBuilder(builder: (context, constraint) {
          return CustomPaint(
            painter: _DiagnosisChartPainter(items: data),
            size: Size(constraint.maxWidth, constraint.maxHeight),
          );
        }),
      ),
    );
  }
}

class _DiagnosisChartPainter extends CustomPainter {
  final List<DiagnosisChartData> items;

  final String highestValue = '5.0';
  final String middleValue = '2.5';
  final String lowestValue = '0';

  final double measuringSpaceLeft = 27;
  final double bottomTitleSpace = 25;
  final double normAreaMargin = 3;
  final double measureLineTopY = 10;
  final double chartWidth = 26;

  double get widthHalf => chartWidth / 2;

  double get measureLineMiddleY => measureLineTopY + measureLineSpace;
  double measureLineSpace = -1;

  double get baseLineY => measureLineTopY + (measureLineSpace * 2);

  _DiagnosisChartPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    calculatePositions(size);

    drawMeasuringLines(canvas, size);
    drawMeasuringTexts(canvas, size);
    drawBarChartsAndRelated(canvas, size);
    drawBaseLine(canvas, size);
  }

  void calculatePositions(Size size) {
    measureLineSpace = (size.height - measureLineTopY - bottomTitleSpace) / 2;

    final totalWidth = size.width - measuringSpaceLeft;
    final distance = totalWidth / items.length;
    final maxHeight = baseLineY - measureLineTopY;
    final startY = measureLineTopY;

    for (int i = 0; i < items.length; i++) {
      final highRangeRate = 1 - (items[i].normalRangeHigh / 5);
      final lowRangeRate = 1 - (items[i].normalRangeLow / 5);
      final normStartY = startY + (maxHeight * highRangeRate);
      final normEndY = startY + (maxHeight * lowRangeRate);

      if (items.length == 1) {
        items.first.normalStartOffset = Offset(measuringSpaceLeft, normStartY);
        items.first.normalEndOffset = Offset(size.width, normEndY);
        break;
      }

      if (i == 0) {
        final normEndX = measuringSpaceLeft + distance - normAreaMargin;
        items[i].normalStartOffset = Offset(measuringSpaceLeft, normStartY);
        items[i].normalEndOffset = Offset(normEndX, normEndY);
        continue;
      }

      if (i > 0 && i < items.length - 1) {
        final normStartX = measuringSpaceLeft + (distance * i) + normAreaMargin;
        final normEndX = normStartX + distance - (normAreaMargin * 2);
        items[i].normalStartOffset = Offset(normStartX, normStartY);
        items[i].normalEndOffset = Offset(normEndX, normEndY);
        continue;
      }

      final normStartX = measuringSpaceLeft + (distance * i) + normAreaMargin;
      items[i].normalStartOffset = Offset(normStartX, normStartY);
      items[i].normalEndOffset = Offset(size.width, normEndY);
    }
  }

  void drawMeasuringLines(Canvas canvas, Size size) {
    assert(measureLineSpace != -1);

    final double startX = measuringSpaceLeft;
    final double endX = size.width;

    final paint = Paint()
      ..strokeWidth = 1
      ..color = Palette.grey02Line
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(startX, measureLineTopY),
      Offset(endX, measureLineTopY),
      paint,
    );
    canvas.drawLine(
      Offset(startX, measureLineMiddleY),
      Offset(endX, measureLineMiddleY),
      paint,
    );

    paint.strokeWidth = 2;
    paint.color = Palette.black01Basic;
    canvas.drawLine(Offset(startX, baseLineY), Offset(endX, baseLineY), paint);
  }

  void drawBarChartsAndRelated(Canvas canvas, Size size) {
    for (final data in items) {
      drawNormalRangeRectangle(data, canvas);
      drawCategoryTitle(data, canvas);
      drawBarCharts(data, canvas);
    }
  }

  void drawNormalRangeRectangle(DiagnosisChartData data, Canvas canvas) {
    assert(data.normalStartOffset.dx != 0 || data.normalEndOffset.dx != 0);

    final paint = Paint()
      ..strokeWidth = 1
      ..color = Palette.grey04Inactive.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final rectangle = Rect.fromPoints(
      data.normalStartOffset,
      data.normalEndOffset,
    );
    canvas.drawRect(rectangle, paint);
  }

  void drawCategoryTitle(DiagnosisChartData data, Canvas canvas) {
    final title = getTextSpanOf(data.category);
    final titleDx = data.normalStartOffset.dx;
    final titleDy = baseLineY + 8;
    final textPainter = TextPainter()
      ..text = title
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout(minWidth: data.normalEndOffset.dx - titleDx);
    textPainter.paint(canvas, Offset(titleDx, titleDy));
  }

  void drawBarCharts(DiagnosisChartData data, Canvas canvas) {
    final hasLateDiagnosisDone = data.lateValue != null;

    final barPainter = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final maxHeight = baseLineY - measureLineTopY;

    final earlyStartX = hasLateDiagnosisDone
        ? data.centerX - chartWidth
        : data.centerX - widthHalf;
    final earlyHeightRate = 1 - (data.earlyValue) / 5;
    final earlyHeightY = measureLineTopY + (maxHeight * earlyHeightRate);

    drawChart(
      canvas,
      barPainter,
      earlyStartX,
      earlyHeightY,
      Palette.retroMint04Dark,
      Palette.retroMint03Basic,
      data.earlyValue,
    );

    if (!hasLateDiagnosisDone) return;

    final lateStartX = earlyStartX + chartWidth;
    final lateHeightRate = 1 - (data.lateValue!) / 5;
    final lateHeightY = measureLineTopY + (maxHeight * lateHeightRate);

    drawChart(
      canvas,
      barPainter,
      lateStartX,
      lateHeightY,
      Palette.retroBlue04Dark,
      Palette.retroBlue03Basic,
      data.lateValue!,
    );
  }

  void drawChart(
    Canvas canvas,
    Paint barPainter,
    double startX,
    double startY,
    Color outerColor,
    Color innerColor,
    double value,
  ) {
    const padding = 2;
    final outerStartXY = Offset(startX, startY);
    final outerEndXY = Offset(startX + chartWidth, baseLineY);
    final innerStartXY = Offset(startX + padding, startY + padding);
    final innerEndXY = Offset(startX + chartWidth - padding, baseLineY);

    final outerRectangle = Rect.fromPoints(outerStartXY, outerEndXY);
    final innerRectangle = Rect.fromPoints(innerStartXY, innerEndXY);

    drawRect(canvas, outerRectangle, barPainter, 5, outerColor);
    drawRect(canvas, innerRectangle, barPainter, 3, innerColor);
    drawChartValueText(canvas, Offset(startX, startY + 7), value);
  }

  void drawChartValueText(Canvas canvas, Offset position, double value) {
    if (value <= 0) return;

    final text = TextSpan(
      text: value.toString(),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
    final textPainter = TextPainter()
      ..text = text
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout(minWidth: chartWidth);

    if (position.dy + textPainter.height <= baseLineY) {
      textPainter.paint(canvas, position);
    }
  }

  void drawRect(
    Canvas canvas,
    Rect rect,
    Paint painter,
    double radius,
    Color color,
  ) {
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      painter..color = color,
    );
  }

  void drawMeasuringTexts(Canvas canvas, Size size) {
    final textTop = getTextSpanOf(highestValue);
    final textMiddle = getTextSpanOf(middleValue);
    final textBottom = getTextSpanOf(lowestValue);
    const dx = 0.0;

    final textPainter = TextPainter()
      ..text = textTop
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.right
      ..layout();
    final textHeight = textPainter.height;

    textPainter.paint(canvas, Offset(dx, measureLineTopY - (textHeight / 2)));
    textPainter
      ..text = textMiddle
      ..layout();
    textPainter.paint(
        canvas, Offset(dx, measureLineMiddleY - (textHeight / 2)));
    textPainter
      ..text = textBottom
      ..layout(minWidth: 22);
    textPainter.paint(canvas, Offset(dx, baseLineY - (textHeight / 2)));
  }

  void drawBaseLine(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..color = Palette.grey02Line
      ..style = PaintingStyle.stroke;

    final double startX = measuringSpaceLeft;
    final double endX = size.width;

    paint.strokeWidth = 2;
    paint.color = Palette.black01Basic;
    canvas.drawLine(Offset(startX, baseLineY), Offset(endX, baseLineY), paint);
  }

  TextSpan getTextSpanOf(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _NormalRangeIndicator extends StatelessWidget {
  const _NormalRangeIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Palette.grey04Inactive.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '정상범위',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagnosisCategoryGuide extends StatelessWidget {
  const _DiagnosisCategoryGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: const EdgeInsets.only(
        top: 10,
        left: 21,
      ),
      decoration: BoxDecoration(
          color: Palette.white01Basic, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGuideColorBox(
            Palette.retroMint03Basic,
            Palette.retroMint04Dark,
          ),
          const SizedBox(width: 6),
          _buildGuideText('Data A'),
          const SizedBox(width: 12),
          _buildGuideColorBox(
            Palette.retroBlue03Basic,
            Palette.retroBlue04Dark,
          ),
          const SizedBox(width: 6),
          _buildGuideText('Data B'),
        ],
      ),
    );
  }

  Widget _buildGuideColorBox(Color color, Color borderColor) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildGuideText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
