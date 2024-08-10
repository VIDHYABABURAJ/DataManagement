import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<bool> isAdmin(User user) async{
    final snapshot = await _database.collection('adminUser').doc(user.uid).get();
    return snapshot.data() ? ['role'] == 'admin';
  }
  Future<void> registerService(
      {required String name,
        required String email,
        required String role,
        required String password}) async{
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _database.collection('users').doc(user.user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'role' : role
      });
    }catch(e){
      rethrow;
    }
  }
  Future<void> addLocation({
    required String country,
    required String state,
    required String district,
    required String city,
  }) async {
    await _database.collection('locations').add({
      'country': country,
      'state': state,
      'district': district,
      'city': city,
    });
  }

  Future<String> signIn( String email,String password) async{
     try{

       final userCredential =  await _auth.signInWithEmailAndPassword(email: email, password: password);
       // Retrieve the signed-in user
       User? user = userCredential.user;

       if (user != null) {



         DocumentSnapshot documentSnapshot = await _database
             .collection('users')
             .doc(user.uid)
             .get();

         if (documentSnapshot.exists) {
           Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString('role', data!['role']);

           return data['role'];

         } else {

           throw  Exception('No data');

         }
       } else {

         throw Exception('Sigin faild');


       }



     } catch(e){
       rethrow;

     }

  }



  Future<void> signOut() async{

    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('role');



  }
}