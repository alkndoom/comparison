import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 250,
            height: 150,
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                const Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 7.0),
                Text(
                  user.email!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton.icon(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Sign Out'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
