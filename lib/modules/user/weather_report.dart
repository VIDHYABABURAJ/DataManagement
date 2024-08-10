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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("Weather Report",style: TextStyle(color: Colors.white),)),
      ),
      body: FutureBuilder(
        future:WeatherService().getWeatherReport(widget.locations) ,
        builder:(context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          }else{
            final datareport = snapshot.data;
            return ListView.builder(
              itemCount: datareport!.length,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        height: 150,
                        width: 250,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("City : ${datareport[index].name}",style: TextStyle(color: Colors.white,fontSize: 20,),),
                              Text("Temprature : ${kelvintoTemp(temp:datareport[index].main!.temp).toStringAsFixed(0)}°C",style: TextStyle(color: Colors.white,fontSize: 20,),),
                              Text("FeelsLike : ${datareport[index].wind!.speed} Km/hr",style: TextStyle(color: Colors.white,fontSize: 20,),),
                              Text("Humidity : ${datareport[index].main!.humidity}°C",style: TextStyle(color: Colors.white,fontSize: 20,),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                    //ListTile(
                  //  title:
                  //);
                },
            );
          }
        },
      )
    );
  }
}
