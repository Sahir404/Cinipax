import 'package:flutter/material.dart';

 class UserDetailProvider with ChangeNotifier {
  String _userEmail="";

  setUserEmail ( String Email)
  {
   _userEmail = Email;
   notifyListeners();
  }
  String getUserEmail()
  {
   return _userEmail;
  }
 }