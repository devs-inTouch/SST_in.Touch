
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
      return const Icon(Icons.cloud, color: Colors.white);
    }

    switch (_weather?.weatherMain) {
      case 'Clear':
        return const Icon(Icons.wb_sunny, color: Colors.white);
      case 'Clouds':
        return const Icon(Icons.cloud, color: Colors.white);
      case 'Rain':
        return const Icon(Icons.beach_access, color: Colors.white);
      case 'Snow':
        return const Icon(Icons.ac_unit, color: Colors.white);
      default:
        return const Icon(Icons.cloud, color: Colors.white);
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '-Meteorologia-',
              style: textStyleBar,
            ),
          ),
    Expanded(
    child: SingleChildScrollView(
    child: Container(
    padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: _weather == null
                      ? const CircularProgressIndicator()
                      : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _getWeatherIcon(),
                          const SizedBox(width: 16.0),
                          Text(
                            '${_weather?.temperature?.celsius?.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '${_weather?.weatherDescription}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Wind: ${_weather?.windSpeed} m/s',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Humidity: ${_weather?.humidity}%',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    ),
    ),
    ),
        ],
      ),
    );
  }
}
