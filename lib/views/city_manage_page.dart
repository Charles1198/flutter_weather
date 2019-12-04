import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_weather/bean/city_weather.dart';
import 'package:flutter_weather/constant/assets_names.dart';
import 'package:flutter_weather/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class CityManagePage extends StatefulWidget {
  @override
  _CityManagePageState createState() => _CityManagePageState();
}

class _CityManagePageState extends State<CityManagePage> {
  WeatherProvider _weatherProvider;
  List<CityWeather> _cityWeatherList = List();
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherProvider == null) {
      _weatherProvider = Provider.of<WeatherProvider>(context);
    }
    _cityWeatherList = _weatherProvider.getCityWeatherList();
    return Scaffold(
      appBar: AppBar(title: Text('城市管理'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _editMode = !_editMode),
        child: Icon(_editMode ? Icons.done : Icons.edit),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == _cityWeatherList.length) {
              return _cityAddItem();
            } else {
              return _cityItem(index);
            }
          },
          itemCount: _cityWeatherList.length + 1,
        ),
      ),
    );
  }

  Widget _cityItem(int index) {
    CityWeather cityWeather = _cityWeatherList[index];
    String weather = cityWeather.weather == null ? '' : cityWeather.weather.result.weather;
    String temp = cityWeather.weather == null ? '' : cityWeather.weather.result.temp;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0X11000000)))),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(cityWeather.cityName, style: TextStyle(fontSize: 24)),
              Text(cityWeather.cityParent.isNotEmpty ? cityWeather.cityParent : '中国'),
            ],
          ),
          Expanded(child: Container()),
          Text(weather),
          Text(temp, style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)),
          Container(
            height: 32,
            alignment: Alignment.topCenter,
            child: SizedBox(width: 16, height: 16, child: SvgPicture.asset(SVG_CELSIUS_FILL, color: Colors.black54)),
          ),
          Offstage(
            offstage: !_editMode,
            child: IconButton(
              icon: Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () => _weatherProvider.removeCity(index),
            ),
          )
        ],
      ),
    );
  }

  Widget _cityAddItem() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.all(16),
      child: Offstage(
        offstage: !_editMode,
        child: IconButton(
          icon: Icon(Icons.add_circle_outline, color: Colors.lightBlue),
          onPressed: () {
            Navigator.pushNamed(context, '/cityAdd').then((city) {
              _weatherProvider.addCity(city);
            });
          },
        ),
      ),
    );
  }
}
