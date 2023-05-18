
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import 'constants.dart';

class WeatherBox extends StatefulWidget {
  final String location;

  const WeatherBox({Key? key, required this.location}) : super(key: key);

  @override
  _WeatherBoxState createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
  WeatherFactory wf = WeatherFactory("791419c029c33fc5048c2cba277d742b");
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    _weather = await wf.currentWeatherByCityName(widget.location);
    setState(() {});
  }

  Icon _getWeatherIcon() {
    if (_weather == null) {
      return Icon(Icons.cloud, color: Colors.white);
    }

    switch (_weather?.weatherMain) {
      case 'Clear':
        return Icon(Icons.wb_sunny, color: Colors.white);
      case 'Clouds':
        return Icon(Icons.cloud, color: Colors.white);
      case 'Rain':
        return Icon(Icons.beach_access, color: Colors.white);
      case 'Snow':
        return Icon(Icons.ac_unit, color: Colors.white);
      default:
        return Icon(Icons.cloud, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxMainMenuDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            decoration: topBarDecoration,
            padding: EdgeInsets.all(16.0),
            child: Text(
              '-Meteorologia-',
              style: textStyleBar,
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: _weather == null
                      ? CircularProgressIndicator()
                      : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _getWeatherIcon(),
                          SizedBox(width: 16.0),
                          Text(
                            '${_weather?.temperature?.celsius?.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '${_weather?.weatherDescription}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Wind: ${_weather?.windSpeed} m/s',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Humidity: ${_weather?.humidity}%',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '${DateFormat('HH:mm').format(DateTime.now())}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
