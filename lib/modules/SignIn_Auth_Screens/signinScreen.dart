
import 'package:data_storage_management/main.dart';
import 'package:data_storage_management/modules/SignIn_Auth_Screens/signUpScreen.dart';
import 'package:data_storage_management/modules/admin/admin_dashboard.dart';
import 'package:data_storage_management/modules/user/user_dashboard.dart';
import 'package:data_storage_management/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/firebasehelper.dart';
import '../../widgets/grey_txt.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email =TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;
  bool _isValid = false;
  String emailError = '';
  String _errorMsg = '';


  void validateEmail() {
    if (email.text.isEmpty) {
      setState(() {
        emailError = 'Email required';
      });
    } else if (!isEmailValid()) {
      setState(() {
        emailError = 'Enter a valid email address';
      });
    } else {
      setState(() {
        emailError = '';
      });
    }
  }
  bool isEmailValid() {
    return RegExp(r'^[\w-]+@[a-zA-Z]+\.[a-zA-Z]{2,}$')
        .hasMatch(email.text);
  }

  bool validatepassword() {
    _errorMsg = '';
    if (password.text.length < 6) {
      _errorMsg += '. Password must be longer than 6 charecters\n';
    }
    if (!password.text.contains(RegExp('[A-Z]'))) {
      _errorMsg += '. Upper case Letter is missing\n';
    }
    if (!password.text.contains(RegExp('[a-z]'))) {
      _errorMsg += '. Lower case letter is missing\n';
    }
    if (!password.text.contains(RegExp('[0-9]'))) {
      _errorMsg += '• Digit is missing.\n';
    }
    if (!password.text.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMsg += '• Special character is missing.\n';
    }
    return _errorMsg.isEmpty;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage("asset/images/loginpage_img.png")),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                child: TextField(
                  controller: email,
                  style: TextStyle(height: 1),
                  decoration: InputDecoration(
                      label: Text("EmailId"),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                child: TextField(
                  controller: password,
                  style: TextStyle(height: 1),
                  decoration: InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                )),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                ),
                onPressed: () {
                  loginHandler(context);
                },
                child: Text(
                  "LogIn",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GreyText(txt: "You don't have an Account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                },child: GreyText(txt: 'Register here',),)
              ],
            )
          ],
        ),
      ),
    );
  }
  void loginHandler(BuildContext context) async {
    print(validatepassword());
    _isValid = true;
    validateEmail();

    if (_isValid && emailError.isEmpty) {
      try {
        setState(() {
          loading = true;
        });
       final checkRole =  await Provider.of<AuthService>(context, listen: false).signIn(email.text, password.text);

       checkRole == 'admin' ? Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashBoard(),)) :Navigator.push(context, MaterialPageRoute(builder: (context) => UserDashboard(),)) ;
        setState(() {
          loading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          custompopup(context: context, title: handleException(e));
        }
        setState(() {
          loading = false;
        });
      }
    } else {
      if (emailError.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '$emailError',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '$_errorMsg',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

}
