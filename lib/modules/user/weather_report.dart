import 'package:data_storage_management/services/weather_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherReport extends StatefulWidget {
  final List<Map<String, String>> locations;
  WeatherReport({super.key, required this.locations});

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  double kelvintoTemp({required final temp}) {
    // final kelvin = _climate!.main!.temp;
    final keltoTemp = temp - 273.15;
    return keltoTemp;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(62, 45, 140, 1),
        ),
        body: FutureBuilder(
              future: WeatherService().getWeatherReport(widget.locations),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else {
                  final datareport = snapshot.data;
                  return ListView.builder(
                    itemCount: datareport!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(top: 50),
                          height: screenSize.height,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: AlignmentDirectional.bottomEnd,
                                  colors: [
                                Color.fromRGBO(157, 82, 172, 0.7),
                                Color.fromRGBO(62, 45, 143, 1),
                              ])),
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Image(
                                  image: AssetImage('asset/images/cloud.png'),
                                  width: 180,
                                  height: 180,
                                ),
                                Text(
                                  "${datareport[index].name}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${kelvintoTemp(temp: datareport[index].main!.temp).toStringAsFixed(0)}°C",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${datareport[index].wind!.speed} Km/h",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 25),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Max: ${kelvintoTemp(temp: datareport[index].main!.tempMax).toStringAsFixed(0)}°C",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Min: ${kelvintoTemp(temp: datareport[index].main!.tempMin).toStringAsFixed(0)}°C",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Image(image: AssetImage("asset/images/House.png")),
                              ])));
                    },
                  );
                }
              },
            ),
         );
  }
}
