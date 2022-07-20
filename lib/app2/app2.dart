import 'package:comparison/app2/screens/auth_screen/auth_screen.dart';
import 'package:comparison/app2/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App2 extends StatefulWidget {
  const App2({Key? key}) : super(key: key);

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text('Something went wrong')));
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
