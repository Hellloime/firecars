import 'package:fire_cars/services/authentication.dart';
import 'package:fire_cars/services/dbservices.dart';
import 'package:fire_cars/views/login.dart';
import 'package:fire_cars/views/profile/profile.dart';
import 'package:fire_cars/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/carModel.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
      StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      ),

      StreamProvider<List<Car>>.value(
         initialData: [],
        value: DatabaseService().cars,
        ),
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => Wrapper(),
        '/profile': (context) => Profile(),
      },
    );
  }
}
