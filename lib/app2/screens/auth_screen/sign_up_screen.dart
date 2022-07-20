import 'package:comparison/app2/app2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //########################################
  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
  //########################################

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final emailFocus = FocusNode();

  Future signUp() async {
    final bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    /*await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);*/

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
          content: const Text('The email address is already in use. Please try another one.'),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SignUpScreen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
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
                  focusNode: emailFocus,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) => email != null && !EmailValidator.validate(email) && !emailFocus.hasFocus
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) => password != null && password.length < 8
                      ? 'Password should contain at least 8 characters'
                      : null,
                  obscureText: !isPasswordVisible,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      }),
                      icon: isConfirmPasswordVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) => password != null && passwordController.text != confirmPasswordController.text
                      ? 'Password does not match'
                      : null,
                  obscureText: !isConfirmPasswordVisible,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: signUp,
                  label: const Text('Sign Up'),
                  icon: const Icon(Icons.lock_open_rounded),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account?  ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Sign In',
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
      ),
    );
  }
}
