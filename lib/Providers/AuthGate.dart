import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogindemo/Screens/HomeScree.dart';
import 'package:firebaselogindemo/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

Widget AuthGate(){
  final user=FirebaseAuth.instance.currentUser;

  if(user!=null){
    return HomeScreen();
  }
  else{
    return LoginScreen();
  }
}