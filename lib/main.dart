import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rijksmuseum/controller/collectives_bloc.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/pages/splash_screen.dart';






void main() async {

  await dotenv.load(fileName: ".env");
  MobileAppItems.apiKey= dotenv.env['API_KEY']!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(collectivesBloc: CollectivesBloc(),)
    );
  }
}
