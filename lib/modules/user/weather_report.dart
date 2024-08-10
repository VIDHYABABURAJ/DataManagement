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
                    child: Container(
                      height: 150,
                      width: 250,
                      color: Colors.red,
                    ),
                  );
                    //ListTile(
                  //  title: Text(datareport[index].name),
                  //);
                },
            );
          }
        },
      )
    );
  }
}
