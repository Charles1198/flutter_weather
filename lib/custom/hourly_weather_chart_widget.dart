import 'package:flutter/material.dart';
import 'package:flutter_weather/bean/weather.dart';

class HourlyWeatherChartWidget extends StatelessWidget {
  /// 天气数据
  final List<Hourly> hourlyWeather;
  final double chartHeight = 160;
  final double chartWidth = 50.0 * 24;

  HourlyWeatherChartWidget(this.hourlyWeather);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: chartWidth,
      height: chartHeight,
      child: CustomPaint(
        painter: _HourlyWeatherChartPainter(hourlyWeather, chartWidth, chartHeight),
      ),
    );
  }
}

class _HourlyWeatherChartPainter extends CustomPainter {
  List<Hourly> _hourlyWeather;
  double _chartWidth;

  /// 天气线性图从上到下：气温数字、气温折线、天气图标、小时数字
  double _timeLabelHeight = 30;
  double _weatherIconHeight = 30;
  double _tempLabelHeight = 20;

  /// 气温
  int _tempHigh = 100;
  int _tempLow = 100;
  List<int> _hourlyTemp = List();
  List<Offset> _hourlyTempPoint = List();

  _HourlyWeatherChartPainter(List<Hourly> hourlyWeather, double chartWidth, double chartHeight) {
    _hourlyWeather = hourlyWeather;
    _chartWidth = chartWidth;

    for (Hourly hourly in _hourlyWeather) {
      // 逐小时气温
      int tempInt = int.parse(hourly.temp);
      _hourlyTemp.add(tempInt);

      // 最高/最低气温
      if (_tempHigh == 100) {
        _tempHigh = tempInt;
        _tempLow = tempInt;
      } else {
        if (tempInt > _tempHigh) {
          _tempHigh = tempInt;
        }
        if (tempInt < _tempLow) {
          _tempLow = tempInt;
        }
      }
    }

    for (int i = 0; i < _hourlyTemp.length; i++) {
      // 温差
      int tempDiff = _tempHigh - _tempLow;

      // 当前温度x方向位置
      double pointOfTempX = (chartWidth / 24) * (i + 0.5);

      // 温度曲线占图表y方向高度
      double tempLineOffset = chartHeight - _timeLabelHeight - _weatherIconHeight - _tempLabelHeight;
      // 当前温度y方向位置
      double pointOfTempY =
          chartHeight - _timeLabelHeight - _weatherIconHeight - (_hourlyTemp[i] - _tempLow) / tempDiff * tempLineOffset;

      _hourlyTempPoint.add(Offset(pointOfTempX, pointOfTempY));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawTempLine(canvas);
    _drawTempLabel(canvas);
    _drawTimeLabel(canvas, size.height - _timeLabelHeight);
    _drawWeatherLabel(canvas, size.height - _timeLabelHeight - _weatherIconHeight);
    _drawVerticalLine(canvas, size.height - _timeLabelHeight - _weatherIconHeight);
  }

  _drawTempLine(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    Paint maskPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8);

    Path tempLinePath = Path();
    Path tempLineMaskPath = Path();

    for (int i = 0; i < _hourlyTempPoint.length; i++) {
      if (i == 0) {
        tempLinePath.moveTo(_hourlyTempPoint[i].dx, _hourlyTempPoint[i].dy);
        tempLineMaskPath.moveTo(_hourlyTempPoint[i].dx, _hourlyTempPoint[i].dy + 4);
      } else {
        tempLinePath.lineTo(_hourlyTempPoint[i].dx, _hourlyTempPoint[i].dy);
        tempLineMaskPath.lineTo(_hourlyTempPoint[i].dx, _hourlyTempPoint[i].dy + 4);
      }
    }
    canvas.drawPath(tempLinePath, paint);
    canvas.drawPath(tempLineMaskPath, maskPaint);
  }

  _drawTempLabel(Canvas canvas) {
    for (int i = 0; i < _hourlyTemp.length; i++) {
      TextSpan textSpan = TextSpan(text: '${_hourlyTemp[i]}˚', style: TextStyle(color: Colors.black87));
      TextPainter textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
      textPainter.layout(maxWidth: 50, minWidth: 50);
      textPainter.paint(canvas, Offset(_chartWidth / 24 * i, _hourlyTempPoint[i].dy - 20));
    }
  }

  _drawTimeLabel(Canvas canvas, double y) {
    for (int i = 0; i < _hourlyTemp.length; i++) {
      TextSpan textSpan = TextSpan(text: '${_hourlyWeather[i].time}', style: TextStyle(color: Colors.black87));
      TextPainter textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
      textPainter.layout(maxWidth: 50, minWidth: 50);
      textPainter.paint(canvas, Offset(_chartWidth / 24 * i, y));
    }
  }

  _drawWeatherLabel(Canvas canvas, double y) {
    for (int i = 0; i < _hourlyWeather.length; i++) {
      TextSpan textSpan = TextSpan(text: '${_hourlyWeather[i].weather}', style: TextStyle(color: Colors.black87));
      TextPainter textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
      textPainter.layout(maxWidth: 50, minWidth: 50);
      textPainter.paint(canvas, Offset(_chartWidth / 24 * i, y));


    }
  }

  _drawVerticalLine(Canvas canvas, double y) {
    Paint paint = Paint()
      ..color = Color(0X10000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    for (Offset point in _hourlyTempPoint) {
      canvas.drawLine(Offset(point.dx, point.dy), Offset(point.dx, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
