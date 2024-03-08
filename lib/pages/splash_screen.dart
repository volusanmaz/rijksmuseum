import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:rijksmuseum/main.dart';
import 'package:rijksmuseum/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();

    // Wait for 3 seconds and then navigate to the home screen
    if(!MyApp.HomeScreenShown) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).push(
          CubePageRoute(
            enterPage: HomeScreen(),
            exitPage: SplashScreen(),
            duration: const Duration(milliseconds: 900),
          ),
        );
      });
      MyApp.HomeScreenShown=true;



    }}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
