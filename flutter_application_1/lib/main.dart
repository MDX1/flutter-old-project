import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MaterialApp(
 theme: ThemeData(
    primaryColor: Colors.red,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => MainScreen(),
    '/items': (context) => Home(),
  },

   ));
}