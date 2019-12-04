import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather/bean/city_weather.dart';
import 'package:flutter_weather/bean/weather.dart';
import 'package:flutter_weather/constant/assets_names.dart';
import 'package:flutter_weather/custom/hourly_weather_chart_widget.dart';
import 'package:flutter_weather/custom/weekly_weather_widget.dart';
import 'package:flutter_weather/util/date_util.dart';

class WeatherTab extends StatefulWidget {
  final CityWeather cityWeather;
  final int index;

  const WeatherTab({Key key, this.cityWeather, this.index}) : super(key: key);

  @override
  _WeatherTabState createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  /// 屏幕尺寸
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _screenPaddingTop = 0;

  /// 天气简讯卡片高度
  double _briefCardHeight = 0;
  double _briefCardHeightPrevious = 0;
  double _briefCardHeightMax = 0;
  double _briefCardHeightMin = 0;

  /// 天气数据
  Result _weatherResult;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _weatherResult = widget.cityWeather.weather != null ? widget.cityWeather.weather.result : null;
    for (Index index in _weatherResult.index) {
      print(index.toJson());
    }
  }

  _initDimensions() {
    if (_screenWidth == 0) {
      _screenWidth = MediaQuery.of(context).size.width;
      _screenHeight = MediaQuery.of(context).size.height;
      _screenPaddingTop = MediaQuery.of(context).padding.top;

      _briefCardHeightMax = _screenHeight - 200;
      _briefCardHeightMin = _screenPaddingTop + 180;
      _briefCardHeightPrevious = _briefCardHeightMax;
      _briefCardHeight = _briefCardHeightPrevious;
    }
  }

  _dateString() {
    String weekDay = DateUtil.getZHWeekDay(DateTime.now());
    String dateString = DateUtil.getDateStrByDateTime(DateTime.now());
    dateString = DateUtil.formatZHDateTime(dateString, DateFormat.ZH_MONTH_DAY, '');
    return '$weekDay，$dateString';
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    double briefCardHeight = _briefCardHeightPrevious - metrics.pixels;
    if (briefCardHeight >= _briefCardHeightMin && briefCardHeight <= _briefCardHeightMax) {
      setState(() => _briefCardHeight = briefCardHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initDimensions();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _weatherMoreWidget(),
          _weatherBriefWidget(),
        ],
      ),
    );
  }

  Widget _weatherBriefWidget() {
    return Container(
      height: _briefCardHeight,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.asset(IMG_HIGH_SIERRA, fit: BoxFit.cover),
            ),
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.only(top: _screenPaddingTop),
              color: Colors.black26,
              child: Stack(
                children: <Widget>[
                  _weatherImageWidget(),
                  _weatherTemperatureWidget(),
                  _locationBigWidget(),
                  _locationSmallWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherImageWidget() {
    // 图片size最小值是60最大值是120，随着天气卡片高度现行变化
    double imageSize =
        100 + (_briefCardHeight - _briefCardHeightMin) / (_briefCardHeightMax - _briefCardHeightMin) * 100;
    // 图片左边距与天气卡片当前高度有关
    double imageMarginLeft = (_screenWidth * _briefCardHeight / _briefCardHeightMax - imageSize) / 2;
    // 图片上下居中
    double imageMarginTop = (_briefCardHeight - _screenPaddingTop - imageSize) / 2;
    return Container(
      padding: EdgeInsets.only(top: imageMarginTop, left: imageMarginLeft),
      child: SizedBox(
        width: imageSize,
        height: imageSize,
        child: SvgPicture.asset(AssetsNames.weatherIconName(_weatherResult.img), color: Colors.white),
      ),
    );
  }

  Widget _weatherTemperatureWidget() {
    double containerHeight =
        _briefCardHeightMin - _screenPaddingTop + (_briefCardHeight - _briefCardHeightMin) / _briefCardHeightMax * 120;
    String tempStr = _weatherResult == null ? '' : '${_weatherResult.temp}';
    String weatherBrief = _weatherResult == null
        ? ''
        : '${_weatherResult.weather}  |  ${_weatherResult.winddirect}${_weatherResult.windpower}';
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: containerHeight,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(tempStr, style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child:
                      SizedBox(width: 32, height: 32, child: SvgPicture.asset(SVG_CELSIUS_FILL, color: Colors.white)),
                ),
              ],
            ),
            Text(weatherBrief, style: TextStyle(color: Colors.white70, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _locationBigWidget() {
    double dy = _briefCardHeightMax - _briefCardHeight;
    double opacity = 1 - dy / 80 <= 0 ? 0 : 1 - dy / 80;
    String city = widget.cityWeather.cityName;
    String cityParent = widget.cityWeather.cityParent.isEmpty ? '中国' : widget.cityWeather.cityParent;
    return Offstage(
      offstage: dy >= 80,
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: 180,
          padding: EdgeInsets.only(left: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(city, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  Offstage(offstage: widget.index != 0, child: SizedBox(width: 12)),
                  Offstage(offstage: widget.index != 0, child: Icon(Icons.location_on, color: Colors.white)),
                ],
              ),
              Text(cityParent, style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(_dateString(), style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationSmallWidget() {
    double dy = _briefCardHeight - _briefCardHeightMin;
    double opacity = 1 - dy / 50 <= 0 ? 0 : 1 - dy / 50;
    String city = _weatherResult == null ? '' : _weatherResult.city;
    String cityParent = widget.cityWeather.cityParent.isEmpty ? '中国' : widget.cityWeather.cityParent;
    TextStyle textStyle = TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold);
    return Offstage(
      offstage: dy >= 50,
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: _briefCardHeight,
          padding: EdgeInsets.only(left: 32, bottom: 12),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Offstage(offstage: widget.index != 0, child: Icon(Icons.location_on, color: Colors.white, size: 18)),
              Text(city, style: textStyle),
              Text(' - ', style: textStyle),
              Text(cityParent, style: textStyle),
              SizedBox(width: 16),
              Text(_dateString(), style: textStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _weatherMoreWidget() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification.depth == 0) {
          if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          }
        }
        return true;
      },
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        controller: _scrollController,
        children: <Widget>[
          Container(height: _briefCardHeightMax),
          _fingerTapIndicator(),
          _weatherDataWidget(),
          _weatherHourlyWidget(),
          _weatherWeeklyWidget(),
          _weatherIndexWidget(),
        ],
      ),
    );
  }

  Widget _fingerTapIndicator() {
    Container indicatorChild = Container(
      height: 2,
      width: 60,
      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(2))),
    );
    return Container(
      height: 40,
      padding: EdgeInsets.only(top: 20, bottom: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          indicatorChild,
          indicatorChild,
          indicatorChild,
        ],
      ),
    );
  }

  Widget _weatherDataWidget() {
    String indexOfTemp = '${_weatherResult.templow}˚ ~ ${_weatherResult.temphigh}˚';
    String indexOfWindSpeed = '${_weatherResult.windspeed} m/s';
    String indexOfHumidity = '${_weatherResult.humidity} %';
    String indexOfAirPressure = '${_weatherResult.pressure} hpa';
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _weatherDataItem('温度', indexOfTemp, SVG_CELSIUS_FILL),
              _weatherDataItem('风速', indexOfWindSpeed, SVG_WINDY_FILL),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _weatherDataItem('湿度', indexOfHumidity, SVG_TEMP_COLD_LINE),
              _weatherDataItem('气压', indexOfAirPressure, SVG_TEMP_HOT_LINE),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weatherDataItem(String label, String index, String assetsName) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          SizedBox(width: 20, height: 20, child: SvgPicture.asset(assetsName)),
          Container(
            margin: EdgeInsets.only(left: 8),
            width: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(index, style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherHourlyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16),
          child: Text('今日天气', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        Container(
          margin: EdgeInsets.only(left: 16),
          child: Text('24 小时天气预报', style: TextStyle(color: Colors.black54)),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: HourlyWeatherChartWidget(_weatherResult.hourly),
          ),
        ),
      ],
    );
  }

  Widget _weatherWeeklyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, top: 16),
          child: Text('本周天气', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        Container(
          margin: EdgeInsets.only(left: 16),
          child: Text('7 日天气预报', style: TextStyle(color: Colors.black54)),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: WeeklyWeatherWidget(_weatherResult.daily),
          ),
        ),
      ],
    );
  }

  /// 生活指数，7个：空调指数、运动指数、紫外线指数、感冒指数、洗车指数、空气污染扩散指数、穿衣指数
  Widget _weatherIndexWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, top: 32),
          child: Text('生活指数', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        Container(
          margin: EdgeInsets.only(top: 24),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _weatherIndexItem(_weatherResult.index[0]),
                    _weatherIndexItem(_weatherResult.index[1]),
                    _weatherIndexItem(_weatherResult.index[2]),
                    _weatherIndexItem(_weatherResult.index[3]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _weatherIndexItem(_weatherResult.index[4]),
                    _weatherIndexItem(_weatherResult.index[5]),
                    _weatherIndexItem(_weatherResult.index[6]),
                    Container(width: 72),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _weatherIndexItem(Index index) {
    return Container(
      height: 80,
      width: 72,
      alignment: Alignment.center,
      child: Column(children: <Widget>[Icon(Icons.map), Text(index.ivalue)]),
    );
  }
}
