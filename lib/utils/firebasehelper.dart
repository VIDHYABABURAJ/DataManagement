import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


String handleException(e) {
  print(e.code);
  var status;
  switch (e.code) {
    case "invalid-email":
      status = 'Invalid email';
      return status;
    case "user-disabled":
      status = "User corresponding to the given email has been disabled";
      return status;
    case "user-not-found":
      status = "There is no user corresponding to the given email";
      return status;
    case "wrong-password":
      status = "Password is invalid for the given email";
      return status;
    case "email-already-in-use":
      status =
      "There is already exists an account with the given email address";
      return status;
    case "operation-not-allowed":
      status =
      "Email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.";
      return status;
    case "invalid-credential":
      status = "Your email and password was invalid";
      return status;

    default:
      status = 'something went wrong';
  }
  return status;
}

void custompopup({required BuildContext context, required String title}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
          ),

        ],


      ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'CANCEL'),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],

      );
    },
  );
}
