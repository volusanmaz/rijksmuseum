import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rijksmuseum/controller/consts.dart';
import 'package:rijksmuseum/pages/splash_screen.dart';






void main() async {

  await dotenv.load(fileName: ".env");
  Consts.ApiKey= dotenv.env['API_KEY']!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static bool HomeScreenShown=false;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
