class Weather {
  int status;
  String msg;
  Result result;

  Weather({this.status, this.msg, this.result});

  Weather.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String city;
  int cityid;
  String citycode;
  String date;
  String week;
  String weather;
  String temp;
  String temphigh;
  String templow;
  String img;
  String humidity;
  String pressure;
  String windspeed;
  String winddirect;
  String windpower;
  String updatetime;
  List<Index> index;
  Aqi aqi;
  List<Daily> daily;
  List<Hourly> hourly;

  Result(
    {this.city,
      this.cityid,
      this.citycode,
      this.date,
      this.week,
      this.weather,
      this.temp,
      this.temphigh,
      this.templow,
      this.img,
      this.humidity,
      this.pressure,
      this.windspeed,
      this.winddirect,
      this.windpower,
      this.updatetime,
      this.index,
      this.aqi,
      this.daily,
      this.hourly});

  Result.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    cityid = json['cityid'];
    citycode = json['citycode'];
    date = json['date'];
    week = json['week'];
    weather = json['weather'];
    temp = json['temp'];
    temphigh = json['temphigh'];
    templow = json['templow'];
    img = json['img'];
    humidity = json['humidity'];
    pressure = json['pressure'];
    windspeed = json['windspeed'];
    winddirect = json['winddirect'];
    windpower = json['windpower'];
    updatetime = json['updatetime'];
    if (json['index'] != null) {
      index = new List<Index>();
      json['index'].forEach((v) {
        index.add(new Index.fromJson(v));
      });
    }
    aqi = json['aqi'] != null ? new Aqi.fromJson(json['aqi']) : null;
    if (json['daily'] != null) {
      daily = new List<Daily>();
      json['daily'].forEach((v) {
        daily.add(new Daily.fromJson(v));
      });
    }
    if (json['hourly'] != null) {
      hourly = new List<Hourly>();
      json['hourly'].forEach((v) {
        hourly.add(new Hourly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['cityid'] = this.cityid;
    data['citycode'] = this.citycode;
    data['date'] = this.date;
    data['week'] = this.week;
    data['weather'] = this.weather;
    data['temp'] = this.temp;
    data['temphigh'] = this.temphigh;
    data['templow'] = this.templow;
    data['img'] = this.img;
    data['humidity'] = this.humidity;
    data['pressure'] = this.pressure;
    data['windspeed'] = this.windspeed;
    data['winddirect'] = this.winddirect;
    data['windpower'] = this.windpower;
    data['updatetime'] = this.updatetime;
    if (this.index != null) {
      data['index'] = this.index.map((v) => v.toJson()).toList();
    }
    if (this.aqi != null) {
      data['aqi'] = this.aqi.toJson();
    }
    if (this.daily != null) {
      data['daily'] = this.daily.map((v) => v.toJson()).toList();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Index {
  String iname;
  String ivalue;
  String detail;

  Index({this.iname, this.ivalue, this.detail});

  Index.fromJson(Map<String, dynamic> json) {
    iname = json['iname'];
    ivalue = json['ivalue'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iname'] = this.iname;
    data['ivalue'] = this.ivalue;
    data['detail'] = this.detail;
    return data;
  }
}

class Aqi {
  String so2;
  String so224;
  String no2;
  String no224;
  String co;
  String co24;
  String o3;
  String o38;
  String o324;
  String pm10;
  String pm1024;
  String pm25;
  String pm2524;
  String iso2;
  String ino2;
  String ico;
  String io3;
  String io38;
  String ipm10;
  String ipm25;
  String aqi;
  String primarypollutant;
  String quality;
  String timepoint;
  Aqiinfo aqiinfo;

  Aqi(
    {this.so2,
      this.so224,
      this.no2,
      this.no224,
      this.co,
      this.co24,
      this.o3,
      this.o38,
      this.o324,
      this.pm10,
      this.pm1024,
      this.pm25,
      this.pm2524,
      this.iso2,
      this.ino2,
      this.ico,
      this.io3,
      this.io38,
      this.ipm10,
      this.ipm25,
      this.aqi,
      this.primarypollutant,
      this.quality,
      this.timepoint,
      this.aqiinfo});

  Aqi.fromJson(Map<String, dynamic> json) {
    so2 = json['so2'];
    so224 = json['so224'];
    no2 = json['no2'];
    no224 = json['no224'];
    co = json['co'];
    co24 = json['co24'];
    o3 = json['o3'];
    o38 = json['o38'];
    o324 = json['o324'];
    pm10 = json['pm10'];
    pm1024 = json['pm1024'];
    pm25 = json['pm2_5'];
    pm2524 = json['pm2_524'];
    iso2 = json['iso2'];
    ino2 = json['ino2'];
    ico = json['ico'];
    io3 = json['io3'];
    io38 = json['io38'];
    ipm10 = json['ipm10'];
    ipm25 = json['ipm2_5'];
    aqi = json['aqi'];
    primarypollutant = json['primarypollutant'];
    quality = json['quality'];
    timepoint = json['timepoint'];
    aqiinfo =
    json['aqiinfo'] != null ? new Aqiinfo.fromJson(json['aqiinfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['so2'] = this.so2;
    data['so224'] = this.so224;
    data['no2'] = this.no2;
    data['no224'] = this.no224;
    data['co'] = this.co;
    data['co24'] = this.co24;
    data['o3'] = this.o3;
    data['o38'] = this.o38;
    data['o324'] = this.o324;
    data['pm10'] = this.pm10;
    data['pm1024'] = this.pm1024;
    data['pm2_5'] = this.pm25;
    data['pm2_524'] = this.pm2524;
    data['iso2'] = this.iso2;
    data['ino2'] = this.ino2;
    data['ico'] = this.ico;
    data['io3'] = this.io3;
    data['io38'] = this.io38;
    data['ipm10'] = this.ipm10;
    data['ipm2_5'] = this.ipm25;
    data['aqi'] = this.aqi;
    data['primarypollutant'] = this.primarypollutant;
    data['quality'] = this.quality;
    data['timepoint'] = this.timepoint;
    if (this.aqiinfo != null) {
      data['aqiinfo'] = this.aqiinfo.toJson();
    }
    return data;
  }
}

class Aqiinfo {
  String level;
  String color;
  String affect;
  String measure;

  Aqiinfo({this.level, this.color, this.affect, this.measure});

  Aqiinfo.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    color = json['color'];
    affect = json['affect'];
    measure = json['measure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['color'] = this.color;
    data['affect'] = this.affect;
    data['measure'] = this.measure;
    return data;
  }
}

class Daily {
  String date;
  String week;
  String sunrise;
  String sunset;
  Night night;
  Day day;

  Daily(
    {this.date, this.week, this.sunrise, this.sunset, this.night, this.day});

  Daily.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    week = json['week'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    night = json['night'] != null ? new Night.fromJson(json['night']) : null;
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['week'] = this.week;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    if (this.night != null) {
      data['night'] = this.night.toJson();
    }
    if (this.day != null) {
      data['day'] = this.day.toJson();
    }
    return data;
  }
}

class Night {
  String weather;
  String templow;
  String img;
  String winddirect;
  String windpower;

  Night(
    {this.weather, this.templow, this.img, this.winddirect, this.windpower});

  Night.fromJson(Map<String, dynamic> json) {
    weather = json['weather'];
    templow = json['templow'];
    img = json['img'];
    winddirect = json['winddirect'];
    windpower = json['windpower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weather'] = this.weather;
    data['templow'] = this.templow;
    data['img'] = this.img;
    data['winddirect'] = this.winddirect;
    data['windpower'] = this.windpower;
    return data;
  }
}

class Day {
  String weather;
  String temphigh;
  String img;
  String winddirect;
  String windpower;

  Day({this.weather, this.temphigh, this.img, this.winddirect, this.windpower});

  Day.fromJson(Map<String, dynamic> json) {
    weather = json['weather'];
    temphigh = json['temphigh'];
    img = json['img'];
    winddirect = json['winddirect'];
    windpower = json['windpower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weather'] = this.weather;
    data['temphigh'] = this.temphigh;
    data['img'] = this.img;
    data['winddirect'] = this.winddirect;
    data['windpower'] = this.windpower;
    return data;
  }
}

class Hourly {
  String time;
  String weather;
  String temp;
  String img;

  Hourly({this.time, this.weather, this.temp, this.img});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    weather = json['weather'];
    temp = json['temp'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['weather'] = this.weather;
    data['temp'] = this.temp;
    data['img'] = this.img;
    return data;
  }
}
