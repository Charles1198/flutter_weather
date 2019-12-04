import 'package:flutter/material.dart';
import 'package:flutter_weather/bean/city_weather.dart';
import 'package:flutter_weather/provider/weather_provider.dart';
import 'package:flutter_weather/views/weather_tab.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherProvider _weatherProvider;
  List<CityWeather> _cityWeatherList = List();

  @override
  Widget build(BuildContext context) {
    if (_weatherProvider == null) {
      _weatherProvider = Provider.of<WeatherProvider>(context);
      _weatherProvider.getWeather();
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(children: _weatherTabs()),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.playlist_add, color: Colors.white, size: 32,),
              onPressed: () => Navigator.pushNamed(context, '/cityManage'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _weatherTabs() {
    _cityWeatherList = _weatherProvider.getCityWeatherList();
    List<Widget> tabs = List();
    for(int i = 0; i < _cityWeatherList.length; i++) {
      tabs.add(WeatherTab(cityWeather: _cityWeatherList[i], index: i));
    }
    return tabs;
  }
}
