import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_storage_management/modules/SignIn_Auth_Screens/signinScreen.dart';
import 'package:data_storage_management/modules/user/upload_excelScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_services.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("User Dashboard",style: TextStyle(color: Colors.white),)),
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
        child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image(image: AssetImage('asset/images/usersvector.jpg'),opacity: AlwaysStoppedAnimation(0.3),),
              ),
              Center(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("Welcome User",style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 25, ),),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 600,
                          width: 350,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('locations').snapshots(),
                            builder:(context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError){

                                return Text('Error');
                              }
                              if (snapshot.hasData){
                                List details = snapshot.data!.docs;
                                print(details);

                                return ListView.builder(
                                  itemCount: details.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        height: 150,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          color: Colors.blueGrey.withOpacity(0.8),
                                        ),
                                        //
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Country : ${details[index]['country']}",style: TextStyle(color: Colors.white,fontSize: 20),),
                                              Text("State : ${details[index]['state']}",style: TextStyle(color: Colors.white,fontSize: 20),),
                                              Text("District : ${details[index]['district']}",style: TextStyle(color: Colors.white,fontSize: 20),),
                                              Text("City : ${details[index]['city']}",style: TextStyle(color: Colors.white,fontSize: 20),),

                                            ],
                                          ),
                                        ),

                                      ),
                                    );
                                  },);
                              }
                              return Text("Nodata");
                            } ,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                          ),

                          child: Text("Upload you Excel file",style: TextStyle(color: Colors.white,fontSize: 20),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UploadExcelFile(),));
                          },
                        ),
                      ),
                    ]
                ),
              ),
            ]
        ),
      ),

    );
  }
}
