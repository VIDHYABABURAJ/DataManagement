import 'package:data_storage_management/main.dart';
import 'package:data_storage_management/modules/SignIn_Auth_Screens/signinScreen.dart';
import 'package:data_storage_management/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/firebasehelper.dart';
import '../../widgets/grey_txt.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController username_controller =TextEditingController();
  TextEditingController email_controller =TextEditingController();
  TextEditingController password_controller =TextEditingController();
  bool loading=false;
  String? dropdownvalue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                Image(image: AssetImage('asset/images/loginpage_img.png')),
                Text("Create Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.blueGrey ),),

                Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 30),
                    child: TextFld(controller: username_controller,labeltxt:"Name" ,)
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
                    child: TextFld(controller: email_controller,labeltxt:"EmailId",)
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
                  child: TextFld(controller: password_controller,labeltxt: "Password",),
                ),
                DropdownButton<String>(

                  borderRadius: BorderRadius.circular(10),
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  value: dropdownvalue,
                  icon: Icon(Icons.arrow_drop_down),
                  items: <String>['user', 'admin'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownvalue = value!;
                    });
                  },
                  hint: GreyText(
                    txt: "Admin / User ",
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                    ),
                    onPressed: (){
                      registerHandler();
                    },

                    child: Text("Register now",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GreyText(txt: "Already you have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                    },child: GreyText(txt: 'Login',),)
                  ],
                )
              ]
          ),
        )
    );
  }
  void registerHandler() async {
    if (username_controller.text.isNotEmpty &&
        email_controller.text.isNotEmpty &&
        password_controller.text.isNotEmpty &&
    dropdownvalue!=null
    ) {
      try {
        setState(() {
          loading = true;
        });
        await AuthService().registerService(
          name: username_controller.text,
          email: email_controller.text,
          password: password_controller.text,
          role: dropdownvalue!
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ));
        setState(() {
          loading = false;
        });
      } catch (e) {
        if (context.mounted) {
          custompopup(context: context, title: handleException(e));
        }
      }
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'all fields are required',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
}
