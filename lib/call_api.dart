import 'package:flutter/foundation.dart';

import 'app_constant.dart';
import 'data/model/base_response.dart';
import 'data/model/weather_response.dart';
import 'data/provider/api_client.dart';
import 'data/provider/api_constant.dart';

class CallApi {
  List<String> listIndexHourly = [
    'temperature_2m',
    'relativehumidity_2m',
    'rain',
    'snowfall',
    'snow_depth',
    'weathercode',
    'visibility',
    'windspeed_10m',
    'winddirection_10m'
  ];

  List<String> listIndexDaily = ['weathercode', 'temperature_2m_max', 'temperature_2m_min', 'sunrise', 'sunset', "uv_index_max"];

  Future<WeatherResponse?> getDataWeather(double? lat, double? long) async {
    // try {
    //   List<Placemark> listAddress =
    //   await placemarkFromCoordinates(lat ?? AppConstant.DEFAULT_LATITUDE, long ?? AppConstant.DEFAULT_LONGITUDE);
    //
    //   if (listAddress.isNotEmpty) {
    //     currentAddress.value = '${listAddress.first.subAdministrativeArea}, ${listAddress.first.administrativeArea}';
    //   }
    // } catch (e) {
    //   log('$e');
    // }

    BaseResponse response =
        await ApiClient.instance.request(endPoint: ApiConstant.urlAPiWeather, method: ApiClient.GET, queryParameters: {
      'latitude': '${lat ?? AppConstant.DEFAULT_LATITUDE}',
      'longitude': '${long ?? AppConstant.DEFAULT_LONGITUDE}',
      'hourly': listIndexHourly,
      'daily': listIndexDaily,
      'current_weather': true,
      'timezone': 'auto',
    });

    if (response.result == true) {
      if (kDebugMode) {
        print("Weather success");
      }
      return WeatherResponse.fromJson(response.data);
    } else {
      if (kDebugMode) {
        print("Weather code: ${response.code} - Weather message: ${response.message}");
        print("Weather lat: $lat");
        print("Weather lng: $long");
      }
      return null;
    }
  }
}
