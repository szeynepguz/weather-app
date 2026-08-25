class LocationModel {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      tzId: json['tz_id'] ?? '',
      localtimeEpoch: json['localtime_epoch'] ?? 0,
      localtime: json['localtime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
        'country': country,
        'lat': lat,
        'lon': lon,
        'tz_id': tzId,
        'localtime_epoch': localtimeEpoch,
        'localtime': localtime,
      };
}

class ConditionModel {
  final String text;
  final String icon;
  final int code;

  ConditionModel({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      text: json['text'] ?? '',
      icon: json['icon'] ?? '',
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'icon': icon,
        'code': code,
      };
}

class CurrentModel {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final ConditionModel condition;
  final double windKph;
  final int windDegree;
  final String windDir;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double uv;

  CurrentModel({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.uv,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      lastUpdatedEpoch: json['last_updated_epoch'] ?? 0,
      lastUpdated: json['last_updated'] ?? '',
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
      tempF: (json['temp_f'] as num?)?.toDouble() ?? 0.0,
      isDay: json['is_day'] ?? 0,
      condition: ConditionModel.fromJson(json['condition'] ?? {}),
      windKph: (json['wind_kph'] as num?)?.toDouble() ?? 0.0,
      windDegree: json['wind_degree'] ?? 0,
      windDir: json['wind_dir'] ?? '',
      humidity: json['humidity'] ?? 0,
      cloud: json['cloud'] ?? 0,
      feelslikeC: (json['feelslike_c'] as num?)?.toDouble() ?? 0.0,
      uv: (json['uv'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'last_updated_epoch': lastUpdatedEpoch,
        'last_updated': lastUpdated,
        'temp_c': tempC,
        'temp_f': tempF,
        'is_day': isDay,
        'condition': condition.toJson(),
        'wind_kph': windKph,
        'wind_degree': windDegree,
        'wind_dir': windDir,
        'humidity': humidity,
        'cloud': cloud,
        'feelslike_c': feelslikeC,
        'uv': uv,
      };
}

class CurrentWeatherResponse {
  final LocationModel location;
  final CurrentModel current;

  CurrentWeatherResponse({
    required this.location,
    required this.current,
  });

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
      location: LocationModel.fromJson(json['location'] ?? {}),
      current: CurrentModel.fromJson(json['current'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'current': current.toJson(),
      };
}

class DayModel {
  final double maxTempC;
  final double minTempC;
  final double avgTempC;
  final ConditionModel condition;
  final int dailyChanceOfRain;

  DayModel({
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.condition,
    required this.dailyChanceOfRain,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      maxTempC: (json['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      minTempC: (json['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      avgTempC: (json['avgtemp_c'] as num?)?.toDouble() ?? 0.0,
      condition: ConditionModel.fromJson(json['condition'] ?? {}),
      dailyChanceOfRain: json['daily_chance_of_rain'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'maxtemp_c': maxTempC,
        'mintemp_c': minTempC,
        'avgtemp_c': avgTempC,
        'condition': condition.toJson(),
        'daily_chance_of_rain': dailyChanceOfRain,
      };
}

class ForecastDayModel {
  final String date;
  final int dateEpoch;
  final DayModel day;

  ForecastDayModel({
    required this.date,
    required this.dateEpoch,
    required this.day,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: json['date'] ?? '',
      dateEpoch: json['date_epoch'] ?? 0,
      day: DayModel.fromJson(json['day'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'date_epoch': dateEpoch,
        'day': day.toJson(),
      };
}

class ForecastContainer {
  final List<ForecastDayModel> forecastDay;

  ForecastContainer({required this.forecastDay});

  factory ForecastContainer.fromJson(Map<String, dynamic> json) {
    var list = json['forecastday'] as List? ?? [];
    List<ForecastDayModel> parsedList =
        list.map((i) => ForecastDayModel.fromJson(i)).toList();

    return ForecastContainer(forecastDay: parsedList);
  }

  Map<String, dynamic> toJson() => {
        'forecastday': forecastDay.map((e) => e.toJson()).toList(),
      };
}

class ForecastWeatherResponse {
  final LocationModel location;
  final CurrentModel current;
  final ForecastContainer forecast;

  ForecastWeatherResponse({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory ForecastWeatherResponse.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherResponse(
      location: LocationModel.fromJson(json['location'] ?? {}),
      current: CurrentModel.fromJson(json['current'] ?? {}),
      forecast: ForecastContainer.fromJson(json['forecast'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'current': current.toJson(),
        'forecast': forecast.toJson(),
      };
}