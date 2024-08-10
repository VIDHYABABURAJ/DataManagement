import 'package:data_storage_management/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'modules/SignIn_Auth_Screens/signinScreen.dart';
import 'modules/admin/admin_dashboard.dart';
import 'modules/user/user_dashboard.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String  ? role = prefs.getString('role');

  runApp(
    MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_) => AuthService()),

        ],
   child: MaterialApp(
     debugShowCheckedModeBanner: false,
  home: role  == null ?  SignInScreen() : role == 'admin' ? AdminDashBoard() : UserDashboard()
  ),
   )
  );
}




