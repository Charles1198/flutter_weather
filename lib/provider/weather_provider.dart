import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/bean/all_city.dart';
import 'package:flutter_weather/bean/city_weather.dart';
import 'package:flutter_weather/bean/weather.dart';
import 'package:flutter_weather/util/sp_util.dart';

const String SPK_CITY_WEATHER = 'spKeyCityWeather';

class WeatherProvider extends ChangeNotifier {
  Dio _dio;
  List<CityWeather> cityWeatherList = List();

  getCityWeatherList() => cityWeatherList;

  void getWeather() async {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        headers: {'Authorization': 'APPCODE bd97b2e79bd04995854a3f486cdbc18d'},
      ));
    }

    /// 先获取本地城市天气数据 cityWeatherList 并显示
    await _getWeatherLocal();

    /// 再定位当前城市
    await _getCurrentLocation();

    /// 再获取实时天气
    _getWeatherOnline();
  }

  /// 从本地获取缓存的天气数据
  _getWeatherLocal() async {
    String cityWeatherListString = await SpUtil.getString(SPK_CITY_WEATHER);
    if (cityWeatherListString.isNotEmpty) {
      cityWeatherList = CityWeather.listFromString(cityWeatherListString);
      notifyListeners();
    }
  }

  /// 如果定位成功
  ///     如果 cityWeatherList 不为空，就把第一个城市换成定位到的城市
  ///     否则就把定位到的城市添加到 cityWeatherList
  /// 否则
  ///     那就跳过呗
  _getCurrentLocation() async {
    var queryParameters = {'key': '67e5825e5e4d4f5c0634ac65d71fb72b'};
    Response response = await _dio.get('https://restapi.amap.com/v3/ip', queryParameters: queryParameters);
    if (response.data['status'] == '1') {
      String city = response.data['city'];
      String province = response.data['province'];
      if (cityWeatherList.length == 0) {
        CityWeather cityWeather = CityWeather();
        cityWeather.cityName = city;
        cityWeatherList.add(cityWeather);
        notifyListeners();
      } else if (cityWeatherList[0].cityName != city) {
        cityWeatherList[0].cityName = city;
        cityWeatherList[0].cityParent = province;
        notifyListeners();
      }
    }
  }

  _saveWeatherLocal() {
    String cityWeatherListString = CityWeather.listToString(cityWeatherList);
    SpUtil.setString(SPK_CITY_WEATHER, cityWeatherListString);
  }

  /// 获取实时天气
  _getWeatherOnline() {
    for (CityWeather cityWeather in cityWeatherList) {
      _getWeatherOfCity(cityWeather.cityName);
    }
  }

  _getWeatherOfCity(String cityName) async {
    String url = 'http://jisutqybmf.market.alicloudapi.com/weather/query?city=$cityName';
    Response response = await _dio.get(url);
    Weather weather = Weather.fromJson(response.data);
    if (weather.status == 0) {
      for (CityWeather cityWeather in cityWeatherList) {
        if (cityWeather.cityName == cityName) {
          cityWeather.weather = weather;
          notifyListeners();
          _saveWeatherLocal();
        }
      }
    }
  }

  /// 添加新城市
  addCity(City city) {
    CityWeather cityWeather = CityWeather();
    cityWeather.cityName = city.city;
    cityWeather.cityParent = city.cityParent;
    cityWeatherList.add(cityWeather);

    _getWeatherOnline();
  }

  /// 添加新城市
  removeCity(int cityIndex) {
    cityWeatherList.removeAt(cityIndex);
    notifyListeners();
    _saveWeatherLocal();
  }
}
