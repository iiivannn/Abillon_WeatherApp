import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:api/services/location.dart';

class Networking {
  String appID = "a4c227ab661ad5383b4620eedda67e5d";
  double temp = 0;
  int id = 0;
  String data = '', city = '', desc = '';

  Future<String> getData() async {
    Location location = new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200) {
      return data;
    } else {
      return "Error";
    }
  }

  Future<String> getCity(String newcity) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$newcity&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200) {
      return data;
    } else if (response.statusCode == 400) {
      throw ErrorDescription("Nothing to decode");
    } else if (response.statusCode == 404) {
      throw ErrorDescription("Not found");
    } else {
      throw ErrorDescription("Random error");
    }
  }
}
