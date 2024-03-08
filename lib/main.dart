import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/pages/splash_screen.dart';






void main() async {

  await dotenv.load(fileName: ".env");
  MobileAppConsts.ApiKey= dotenv.env['API_KEY']!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static bool HomeScreenShown=false;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}
