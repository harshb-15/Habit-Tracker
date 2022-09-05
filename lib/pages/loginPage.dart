import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/auth/fire_auth.dart';
import 'package:habit_tracker/auth/validators.dart';

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailTextController,
                    validator: (value) => Validator.validateEmail(email: value),
                  ),
                  TextFormField(
                    controller: _passwordTextController,
                    obscureText: true,
                    validator: (value) =>
                        Validator.validatePassword(password: value),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            User? user =
                                await FireAuth.signInUsingEmailPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                              context: context,
                            );
                            if(user!=null){
                              Navigator.of(context).pushNamed('/home');
                            }
                          }
                        },
                        child: Text("Sign In"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/reg');
                        },
                        child: Text("Register"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
