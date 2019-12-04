import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather/bean/all_city.dart';

class CityAddPage extends StatefulWidget {
  @override
  _CityAddPageState createState() => _CityAddPageState();
}

class _CityAddPageState extends State<CityAddPage> {
  List<City> _cityList = List();
  List<City> _searchedCityList = List();

  @override
  void initState() {
    super.initState();

    _getCityList();
  }

  _getCityList() async {
    String cityJson = await rootBundle.loadString('assets/json/city_json.json');

    AllCity allCity = AllCity.fromJson(jsonDecode(cityJson));
    if (allCity.status == 0) {
      _cityList = allCity.result;
    }
  }

  _searchChanged(String value) {
    if (value.isEmpty) {
      return;
    }
    _searchedCityList.clear();
    for (City city in _cityList) {
      if (city.citycode != null && city.city.contains(value)) {
        setState(() {
          _searchedCityList.add(city);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          textInputAction: TextInputAction.search,
          onChanged: (value) => _searchChanged(value),
          decoration: InputDecoration(border: InputBorder.none, hintText: '搜索国内城市'),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) => _cityWidget(_searchedCityList[index]),
          itemCount: _searchedCityList.length,
        ),
      ),
    );
  }

  Widget _cityWidget(City city) {
    String cityParent = '';
    for (City c in _cityList) {
      if (city.parentid == c.cityid) {
        cityParent = c.city;

        for (City c1 in _cityList) {
          if (c.parentid == c1.cityid) {
            cityParent = '$cityParent，${c1.city}';
          }
        }
      }
    }
    city.cityParent = cityParent;
    String cityString = cityParent.isEmpty ? city.city : '${city.city} - $cityParent';
    return ListTile(title: Text(cityString), onTap: () => Navigator.pop(context, city));
  }
}
