import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/call_api.dart';
import 'package:weather/data/model/weather_response.dart';
import 'app_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'font'
      ),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}


class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              child: Image.network(
                "https://cdn.pixabay.com/photo/2018/11/10/22/57/mountain-3807667_960_720.jpg",
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder(
              future: CallApi().getDataWeather(20, 105),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(strokeWidth: 1),
                  );
                }
                WeatherResponse data = snapshot.data!;
                final listDataDay = [];
                Map weather = AppConstant.listWMOCode
                    .firstWhereOrNull((element) => element['code'] == (data.hourly?.weathercode?[DateTime.now().hour] ?? -1));
                for (var i = 0; i < 7; i++) listDataDay.add({
                  'time': data.daily?.time?[i],
                  'weather': weather,
                  'temperatureMin': data.daily?.temperature2mMin?[i],
                  'temperatureMax': data.daily?.temperature2mMax?[i],
                });
                return SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: size.width,
                      child: Column(
                        children: [
                          space(32),
                          Text(
                            'Hà Nội',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${data.currentWeather!.temperature!.round()}°',
                            style: TextStyle(
                              fontSize: 80,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                              '${AppConstant.listWMOCode.firstWhereOrNull((element) => element['code'] == (data.hourly?.weathercode?[DateTime.now().hour] ?? -1))['desEN']}',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              )
                          ),
                          space(16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Low : ${data.daily?.temperature2mMin?[0].round()}°',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              ),
                              space(16),
                              Text(
                                'High: ${data.daily?.temperature2mMax?[0].round()}°',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              )
                            ],
                          ),
                          space(32),
                          Container(
                            width: size.width,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 16, 2),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${AppConstant.listWMOCode.firstWhereOrNull((element) => element['code'] == (data.hourly?.weathercode?[DateTime.now().hour + 1] ?? -1))['desEN']} in ${(DateTime.now().hour + 1) < 10 ? '0':''}${(DateTime.now().hour + 1) % 24}:00',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                line(),
                                SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        item1(
                                            'Now',
                                            'assets/icons/weather_01.png',
                                            data.hourly!.temperature2m![DateTime.now().hour].round(),
                                            false
                                        ),
                                        for (var i = 1; i <= 23; i++)
                                          item1('${(DateTime.now().hour + i) % 24 < 10? '0' : ''}${(DateTime.now().hour + i) % 24}:00','assets/icons/weather_03.png',data.hourly!.temperature2m![(DateTime.now().hour + i) % 24].round(), true)
                                      ],
                                    ),
                                  ),
                                ),
                                space(16),

                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          space(8),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 16, 2),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Dự báo 7 ngày tới',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                line(),
                                item2(size, 'Now',
                                    listDataDay[0]['temperatureMin'],
                                    listDataDay[0]['temperatureMax'],
                                    data.currentWeather!.temperature!.round(),
                                    true
                                ),
                                for (var i = 1; i < 7; i++)
                                  item2(
                                      size,
                                      DateFormat('EEE').format(DateFormat("yyyy-MM-dd").parse(listDataDay[i]['time'])),
                                      listDataDay[i]['temperatureMin'],
                                      listDataDay[i]['temperatureMax'],
                                      0,
                                      false
                                  )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          space(8),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.3)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Lượng mưa',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Text(
                                              '${data.hourly!.rain![DateTime.now().hour]} mm',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        space(16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.transparent,
                                          child: Image.asset(
                                            'assets/icons/luongmua.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                space(8),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.3)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Độ ẩm",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Text(
                                              '${data.hourly!.relativehumidity2m![DateTime.now().hour]} %',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        space(16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            'assets/icons/doam.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          space(8),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.3)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Tia UV",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            )
                                          ],
                                        ),
                                        space(16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            'assets/icons/UV.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                space(8),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.3)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Gió",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Text(
                                              '${data.hourly!.windspeed10m![DateTime.now().hour]} km/h',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        space(16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            'assets/icons/gio.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          space(8),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.3)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Không khí",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Text(
                                              '${data.hourly!.relativehumidity2m![DateTime.now().hour]} %',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        space(16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            'assets/icons/khongkhi.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                space(8),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.3)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tầm nhìn",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Text(
                                              '${data.hourly!.visibility![DateTime.now().hour].round()} m',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        space(16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            'assets/icons/tamnhin.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          space(32)
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Container item2(Size size, String title, double low, double high, int temp, bool firstIndex) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/weather_01.png',
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                  space(10),
                  Text(
                    '${low.round()}°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                  space(8),
                  Container(
                    width: size.width * 0.2,
                    height: 4,
                    alignment: Alignment((temp < (low + high)/2) ?-(temp - low)/(high - low + 0.01): (temp - low)/(high - low + 0.01), 1),
                    child: firstIndex == true ?Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black
                          )
                      ),
                    ): null,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: <Color> [
                              Colors.greenAccent,
                              Colors.lightGreenAccent,
                              Colors.yellow,
                              Colors.orangeAccent,
                              Colors.orange,
                              Colors.deepOrange
                            ]
                        )
                    ),
                  ),
                  space(8),
                  Text(
                    '${high.round()}°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                ],
              ),
            ],
          ),
          line()
        ],
      ),
    );
  }

  Widget item1(
      String txt,
      String icon,
      int temp,
      bool firstIndex,
  ) {
    return Container(
      width: 60,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Text(
            txt,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),
          ),
          space(16),
          Image.asset(
            icon,
            width: 50,
            fit: BoxFit.cover,
          ),
          space(16),
          Text(
            '${temp}°',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  Widget line() {
    return Divider(color: Colors.white, thickness: 0.3,);
  }

  Widget space(double size) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}
