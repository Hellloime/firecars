import 'package:fire_cars/services/authentication.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLoginProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  image: DecorationImage(
                    image: const AssetImage('assets/vt.png'),
                    fit: BoxFit.contain,
                  )),
            ),
            Text(
              'Fire Cars',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Découvrez et partager les meilleures voitures de luxe 2021',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            inLoginProcess ? const Center(child: CircularProgressIndicator(),):
            ElevatedButton(
                onPressed: () => signIn (), 
                child: const Text('Connectez-vous avec google'))
          ],
        ),
      )),
    );
    
  }

  signIn() {
      setState(() {
        inLoginProcess = true;
        AuthService().signInWithGoogle();
      });
    }
}
