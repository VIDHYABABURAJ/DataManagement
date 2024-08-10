import 'dart:convert';

import 'package:data_storage_management/model/weatherReport_model.dart';
import 'package:http/http.dart' as http;



class WeatherService{
  Future<List<WeatherReportModel>> getWeatherReport(List<Map<String,String>> locations) async{
    List<WeatherReportModel> weatherReport =[];
     for(var location in locations){
       String query = '${location['city']?.replaceAll(' ', '')},${location['state']},${location['country']}';
       final res = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$query&appid=8a42daacec6f47deafa41f28c51931ad'));

       if(res.statusCode == 200){
         var data = jsonDecode(res.body);
         weatherReport.add(WeatherReportModel.fromJson(data));
       }
     }
     return weatherReport;
  }
}