import 'package:data_storage_management/modules/SignIn_Auth_Screens/signinScreen.dart';
import 'package:data_storage_management/modules/admin/location_data.dart';
import 'package:data_storage_management/services/auth_services.dart';
import 'package:data_storage_management/services/weather_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  TextEditingController country_controller = TextEditingController();
  TextEditingController state_controller = TextEditingController();
  TextEditingController district_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Center(
            child: Text(
          "Add Location",
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<AuthService>(context, listen: false).signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => false);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Image(
              image: AssetImage("asset/images/locationvector.jpg"),
              opacity: AlwaysStoppedAnimation(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                    child: TextFormField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: country_controller,
                      decoration: InputDecoration(
                          label: Text('Country'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                    child: TextFormField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: state_controller,
                      decoration: InputDecoration(
                          label: Text('State'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                    child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      controller: district_controller,
                      decoration: InputDecoration(
                          label: Text('District'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                    child: TextFormField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Feild required";
                        }
                        return null;
                      },
                      controller: city_controller,
                      decoration: InputDecoration(
                          label: Text('City'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueGrey),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        if(city_controller.text.isNotEmpty&&
                            district_controller.text.isNotEmpty&&
                            state_controller.text.isNotEmpty&&
                            country_controller.text.isNotEmpty
                        ){
                          AuthService().addLocation(
                              country: country_controller.text,
                              state: state_controller.text,
                              district: district_controller.text,
                              city: city_controller.text);

                          country_controller.clear();
                          state_controller.clear();
                          district_controller.clear();
                          city_controller.clear();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LocationData(),), (route) => false);

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                                content: Text('All feilds are required',style: TextStyle(color: Colors.white),)),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
