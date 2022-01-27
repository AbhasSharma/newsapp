import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var weatherdata; //database
  var errrmsg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController citycontroller = TextEditingController();

  getWeather() async {
    var apikey = "79062606cc05858c3dd05ab81ab3b7e5";
    var baseurl = "https://api.openweathermap.org/data/2.5/weather";

    var url = Uri.parse(
        "$baseurl?q=${citycontroller.text}&appid=$apikey&units=metric");
    var response = await http.get(url);
    print(response.body);
    print(response.body.runtimeType);
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['cod'] == "404"||jsonResponse['cod'] == 401) {
      setState(() {
        errrmsg = jsonResponse['message'];
      });
    } else {
      setState(() {
        weatherdata = jsonResponse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body: Column(
          children: [
            Image.network(
                "https://uxwing.com/wp-content/themes/uxwing/download/27-weather/weather.png"),
            TextField(
              decoration: InputDecoration(hintText: "Enter City name"),
              controller: citycontroller,
            ),
            RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  getWeather();
                }),
            weatherdata != null
                ? Center(
                    child: Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "City Name : ",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(weatherdata['name'] ?? "",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Max temp : ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(weatherdata['main']['temp_max'].toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Min temp : ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(weatherdata['main']['temp_min'].toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Humidity : ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(weatherdata['main']['humidity'].toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Sunrise : ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(weatherdata['sys']['sunrise'].toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Sunset : ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(weatherdata['sys']['sunset'].toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(child: Text(errrmsg)),
          ],
        ));
  }
}