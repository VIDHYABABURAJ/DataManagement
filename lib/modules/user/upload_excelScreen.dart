import 'dart:io';

import 'package:data_storage_management/modules/SignIn_Auth_Screens/signinScreen.dart';
import 'package:data_storage_management/modules/user/weather_report.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_services.dart';
import '../../services/excel_service.dart';

class UploadExcelFile extends StatefulWidget {
  const UploadExcelFile({super.key});

  @override
  State<UploadExcelFile> createState() => _UploadExcelFileState();
}

class _UploadExcelFileState extends State<UploadExcelFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("Upload Excel File",style: TextStyle(color: Colors.white),)),
        actions: [
          IconButton(
              onPressed: () async{
                await Provider.of<AuthService>(context, listen: false).signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => false);
              },
              icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image(image: AssetImage('asset/images/uploadvector.jpg')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                style: ButtonStyle(

                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                ),

                child: Text("Upload your file here",style: TextStyle(color: Colors.white,fontSize: 20),),
                onPressed: () async{
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx','xls'],
                  );
                  if (result != null){
                    File file = File(result.files.single.path!);
                    List<Map<String,String>> location = await ExcelService().parseExcel(file);
print("location");
                    print(location);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherReport(locations: location,)));

                  }else{
                    print("Error");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
