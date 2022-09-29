import 'package:comparison/app1/app1.dart';
import 'package:comparison/app2/app2.dart';
import 'package:comparison/app3/app3.dart';
import 'package:comparison/app4/app4.dart';
import 'package:comparison/app5_spotify_clone/app5.dart';
import 'package:comparison/app6/app6.dart';
import 'package:comparison/custom_widgets/playground.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App5());
}
