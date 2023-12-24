// import 'dart:developer';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-1437851130564968~1791086400');

  // Firebase.initializeApp(
  // ).whenComplete(() {
  //   log("completed");
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artistic Wallpaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          titleSpacing: 20.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          elevation: 20.0,
          backgroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        fontFamily: 'Jannah',
      ),
      home: AnimatedSplashScreen(
        nextScreen: const Home(),
        backgroundColor: Colors.white,
        duration: 1500,
        centered: true,
        splash: Image.asset('assets/images/Artisticwallpaper.png'),
        splashIconSize: 250,
      ),
    );
  }
}
