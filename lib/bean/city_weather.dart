import 'dart:convert';

import 'weather.dart';

class CityWeather extends Object {
  String cityName = '';
  String cityCode;
  Weather weather;

  /// 天气数据里没有，需要另外传入
  String cityParent = '';

  static String listToString(List<CityWeather> cityList) {
    List<Map<String, dynamic>> mapDataList = List();
    for(CityWeather cityWeather in cityList) {
      mapDataList.add(cityWeather.toJson());
    }
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cityList'] = mapDataList;
    return jsonEncode(data);
  }

  static List<CityWeather> listFromString(String jsonString) {
    var list = jsonDecode(jsonString)['cityList'] as List;
    List<CityWeather> cityWeatherList = List();
    for(var item in list) {
      CityWeather cityWeather = CityWeather();
      cityWeather.cityName = item['cityName'];
      cityWeather.cityCode = item['cityCode'];
      cityWeather.cityParent = item['cityParent'];
      cityWeather.weather = Weather.fromJson(item['weather']);
      cityWeatherList.add(cityWeather);
    }
    return cityWeatherList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['cityCode'] = this.cityCode;
    data['cityParent'] = this.cityParent;
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
    return data;
  }
}