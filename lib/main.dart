import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weather_provider.dart';
import 'package:flutter_weather/views/city_add_page.dart';
import 'package:flutter_weather/views/city_manage_page.dart';
import 'package:flutter_weather/views/weather_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white
        ),
        routes: {
          '/': (context) => WeatherPage(),
          '/cityManage': (context) => CityManagePage(),
          '/cityAdd': (context) => CityAddPage(),
        },
      ),
    );
  }
}