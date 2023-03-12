class WeatherResponse {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final CurrentWeather? currentWeather;
  final HourlyUnits? hourlyUnits;
  final Hourly? hourly;
  final DailyUnits? dailyUnits;
  final Daily? daily;

  WeatherResponse({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeather,
    this.hourlyUnits,
    this.hourly,
    this.dailyUnits,
    this.daily,
  });

  WeatherResponse.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'] as double?,
        longitude = json['longitude'] as double?,
        generationtimeMs = json['generationtime_ms'] as double?,
        utcOffsetSeconds = json['utc_offset_seconds'] as int?,
        timezone = json['timezone'] as String?,
        timezoneAbbreviation = json['timezone_abbreviation'] as String?,
        elevation = json['elevation'] as double?,
        currentWeather = (json['current_weather'] as Map<String, dynamic>?) != null
            ? CurrentWeather.fromJson(json['current_weather'] as Map<String, dynamic>)
            : null,
        hourlyUnits = (json['hourly_units'] as Map<String, dynamic>?) != null
            ? HourlyUnits.fromJson(json['hourly_units'] as Map<String, dynamic>)
            : null,
        hourly = (json['hourly'] as Map<String, dynamic>?) != null
            ? Hourly.fromJson(json['hourly'] as Map<String, dynamic>)
            : null,
        dailyUnits = (json['daily_units'] as Map<String, dynamic>?) != null
            ? DailyUnits.fromJson(json['daily_units'] as Map<String, dynamic>)
            : null,
        daily =
        (json['daily'] as Map<String, dynamic>?) != null ? Daily.fromJson(json['daily'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'generationtime_ms': generationtimeMs,
    'utc_offset_seconds': utcOffsetSeconds,
    'timezone': timezone,
    'timezone_abbreviation': timezoneAbbreviation,
    'elevation': elevation,
    'current_weather': currentWeather?.toJson(),
    'hourly_units': hourlyUnits?.toJson(),
    'hourly': hourly?.toJson(),
    'daily_units': dailyUnits?.toJson(),
    'daily': daily?.toJson()
  };
}

class CurrentWeather {
  final double? temperature;
  final double? windspeed;
  final double? winddirection;
  final int? weathercode;
  final String? time;

  CurrentWeather({
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.weathercode,
    this.time,
  });

  CurrentWeather.fromJson(Map<String, dynamic> json)
      : temperature = json['temperature'] as double?,
        windspeed = json['windspeed'] as double?,
        winddirection = json['winddirection'] as double?,
        weathercode = json['weathercode'] as int?,
        time = json['time'] as String?;

  Map<String, dynamic> toJson() => {
    'temperature': temperature,
    'windspeed': windspeed,
    'winddirection': winddirection,
    'weathercode': weathercode,
    'time': time
  };
}

class HourlyUnits {
  final String? time;
  final String? weathercode;
  final String? temperature2m;
  final String? relativehumidity2m;
  final String? precipitation;
  final String? rain;
  final String? snowfall;
  final String? snowDepth;
  final String? visibility;
  final String? windspeed10m;
  final String? winddirection10m;

  HourlyUnits({
    this.time,
    this.weathercode,
    this.temperature2m,
    this.relativehumidity2m,
    this.precipitation,
    this.rain,
    this.snowfall,
    this.snowDepth,
    this.visibility,
    this.windspeed10m,
    this.winddirection10m,
  });

  HourlyUnits.fromJson(Map<String, dynamic> json)
      : time = json['time'] as String?,
        weathercode = json['weathercode'] as String?,
        temperature2m = json['temperature_2m'] as String?,
        relativehumidity2m = json['relativehumidity_2m'] as String?,
        precipitation = json['precipitation'] as String?,
        rain = json['rain'] as String?,
        snowfall = json['snowfall'] as String?,
        snowDepth = json['snow_depth'] as String?,
        visibility = json['visibility'] as String?,
        windspeed10m = json['windspeed_10m'] as String?,
        winddirection10m = json['winddirection_10m'] as String?;

  Map<String, dynamic> toJson() => {
    'time': time,
    'weathercode': weathercode,
    'temperature_2m': temperature2m,
    'relativehumidity_2m': relativehumidity2m,
    'precipitation': precipitation,
    'rain': rain,
    'snowfall': snowfall,
    'snow_depth': snowDepth,
    'visibility': visibility,
    'windspeed_10m': windspeed10m,
    'winddirection_10m': winddirection10m
  };
}

class Hourly {
  final List<String>? time;
  final List<int>? weathercode;
  final List<double>? temperature2m;
  final List<int>? relativehumidity2m;
  final List<double>? snowDepth;
  final List<double>? visibility;
  final List<double>? precipitation;
  final List<double>? windspeed10m;
  final List<int>? winddirection10m;
  final List<double>? rain;
  final List<double>? snowfall;

  Hourly(
      {this.time,
        this.weathercode,
        this.temperature2m,
        this.relativehumidity2m,
        this.snowDepth,
        this.visibility,
        this.rain,
        this.snowfall,
        this.windspeed10m,
        this.winddirection10m,
        this.precipitation});

  Hourly.fromJson(Map<String, dynamic> json)
      : time = (json['time'] as List?)?.map((dynamic e) => e as String).toList(),
        weathercode = (json['weathercode'] as List?)?.map((dynamic e) => e as int).toList(),
        temperature2m = (json['temperature_2m'] as List?)?.map((dynamic e) => e as double).toList(),
        relativehumidity2m = (json['relativehumidity_2m'] as List?)?.map((dynamic e) => e as int).toList(),
        precipitation = (json['precipitation'] as List?)?.map((dynamic e) => e as double).toList(),
        rain = (json['rain'] as List?)?.map((dynamic e) => e as double).toList(),
        snowfall = (json['snowfall'] as List?)?.map((dynamic e) => e as double).toList(),
        windspeed10m = (json['windspeed_10m'] as List?)?.map((dynamic e) => e as double).toList(),
        winddirection10m = (json['winddirection_10m'] as List?)?.map((dynamic e) => e as int).toList(),
        snowDepth = ((json['snow_depth'] as List?)?.map((dynamic e) => e as double).toList()),
        visibility = ((json['visibility'] as List?)?.map((dynamic e) => e as double).toList());

  Map<String, dynamic> toJson() => {
    'time': time,
    'weathercode': weathercode,
    'temperature_2m': temperature2m,
    'relativehumidity_2m': relativehumidity2m,
    'precipitation': precipitation,
    'windspeed_10m': windspeed10m,
    'winddirection_10m': winddirection10m,
    'snow_depth': snowDepth,
    'rain': rain,
    'snowfall': snowfall,
    'visibility': visibility
  };
}

class DailyUnits {
  final String? time;
  final String? weathercode;
  final String? temperature2mMax;
  final String? temperature2mMin;
  final String? sunrise;
  final String? sunset;

  DailyUnits({
    this.time,
    this.weathercode,
    this.temperature2mMax,
    this.temperature2mMin,
    this.sunrise,
    this.sunset,
  });

  DailyUnits.fromJson(Map<String, dynamic> json)
      : time = json['time'] as String?,
        weathercode = json['weathercode'] as String?,
        temperature2mMax = json['temperature_2m_max'] as String?,
        temperature2mMin = json['temperature_2m_min'] as String?,
        sunrise = json['sunrise'] as String?,
        sunset = json['sunset'] as String?;

  Map<String, dynamic> toJson() => {
    'time': time,
    'weathercode': weathercode,
    'temperature_2m_max': temperature2mMax,
    'temperature_2m_min': temperature2mMin,
    'sunrise': sunrise,
    'sunset': sunset
  };
}

class Daily {
  final List<String>? time;
  final List<int>? weathercode;
  final List<double>? temperature2mMax;
  final List<double>? temperature2mMin;
  final List<String>? sunrise;
  final List<String>? sunset;

  Daily({
    this.time,
    this.weathercode,
    this.temperature2mMax,
    this.temperature2mMin,
    this.sunrise,
    this.sunset,
  });

  Daily.fromJson(Map<String, dynamic> json)
      : time = (json['time'] as List?)?.map((dynamic e) => e as String).toList(),
        weathercode = (json['weathercode'] as List?)?.map((dynamic e) => e as int).toList(),
        temperature2mMax = (json['temperature_2m_max'] as List?)?.map((dynamic e) => e as double).toList(),
        temperature2mMin = (json['temperature_2m_min'] as List?)?.map((dynamic e) => e as double).toList(),
        sunrise = (json['sunrise'] as List?)?.map((dynamic e) => e as String).toList(),
        sunset = (json['sunset'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'time': time,
    'weathercode': weathercode,
    'temperature_2m_max': temperature2mMax,
    'temperature_2m_min': temperature2mMin,
    'sunrise': sunrise,
    'sunset': sunset
  };
}