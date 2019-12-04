class AllCity {
  int status;
  String msg;
  List<City> result;

  AllCity({this.status, this.msg, this.result});

  AllCity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = new List<City>();
      json['result'].forEach((v) {
        result.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int cityid;
  int parentid;
  String citycode;
  String city;

  String cityParent = '';

  City({this.cityid, this.parentid, this.citycode, this.city});

  City.fromJson(Map<String, dynamic> json) {
    cityid = json['cityid'];
    parentid = json['parentid'];
    citycode = json['citycode'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityid'] = this.cityid;
    data['parentid'] = this.parentid;
    data['citycode'] = this.citycode;
    data['city'] = this.city;
    return data;
  }
}
