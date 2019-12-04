import 'package:flutter/material.dart';
import 'package:flutter_weather/bean/weather.dart';

class WeeklyWeatherWidget extends StatelessWidget {
  /// 天气数据
  final List<Daily> dailyWeather;

  WeeklyWeatherWidget(this.dailyWeather);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: _dailyWeatherItems()),
    );
  }

  List<Widget> _dailyWeatherItems() {
    List<Widget> items = List();
    for (Daily daily in dailyWeather) {
      items.add(_dailyWeatherItem(daily));
    }
    return items;
  }

  Widget _dailyWeatherItem(Daily daily) {
    Color dayColor;
    if (daily.week.contains('六') || daily.week.contains('日')) {
      dayColor = Colors.orangeAccent;
    } else {
      dayColor = Colors.lightBlue;
    }
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: dayColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Column(
        children: <Widget>[
          Text('${daily.week.replaceAll('星期', '周')}'),
          Text('${daily.day.weather}'),
          Text('${daily.day.temphigh}˚'),
          Text('~'),
          Text('${daily.night.weather}'),
          Text('${daily.night.templow}˚'),
        ],
      ),
    );
  }
}
