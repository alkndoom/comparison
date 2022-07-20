import 'package:comparison/app1/app1.dart';
import 'package:comparison/app2/app2.dart';
import 'package:comparison/app3/app3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App2());
}
