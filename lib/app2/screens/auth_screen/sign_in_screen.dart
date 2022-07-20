import 'package:comparison/app2/app2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignInScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //########################################
  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  //########################################

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  Future signIn() async {

    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print('#ERROR: $e#');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);

      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          content: const Text('The email address or the password is wrong.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            )
          ],
        ),
      );
      return;
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  //########################################

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignInScreen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'name@examle.com',
                  suffixIcon: emailController.text.isEmpty ? null : IconButton(
                    onPressed: () => emailController.clear(),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    }),
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
                obscureText: !isPasswordVisible,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: signIn,
                label: const Text('Sign In'),
                icon: const Icon(Icons.lock_open_rounded),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'No account?  ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign Up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
