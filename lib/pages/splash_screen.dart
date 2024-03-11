import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'dart:convert';
import 'package:rijksmuseum/pages/home_screen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future<List<ArtObject>> fetchData() async {
  try{
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType=EasyLoadingIndicatorType.cubeGrid
      ..indicatorColor = Colors.black
      ..backgroundColor=Colors.grey
      ..textColor = Colors.black;

    EasyLoading.show(status: "Loading",);

    int maxAttempts = 5;
    int attempt = 0;

    while (attempt < maxAttempts) {
      final response = await http.get(Uri.parse(MobileAppItems.CollectionApiAdress("en")));
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Success!");


        Map<String, dynamic> jsonData = json.decode(response.body);
        List<ArtObject> artObjects = [];
        for (var json in jsonData['artObjects']) {
          artObjects.add(ArtObject.fromJson(json));
        }
        MobileAppItems.CollectionData.clear();
        MobileAppItems.CollectionData=await artObjects;
        Future.delayed(Duration(seconds: 3), () {
          MobileAppItems.HomeScreenShown=true;
          Navigator.of(context).push(
            CubePageRoute(
              enterPage: HomeScreen(),
              exitPage: SplashScreen(),
              duration: const Duration(milliseconds: 1500),
            ),
          );
        });
        return artObjects;
      } else {
        attempt++;
        await Future.delayed(Duration(seconds: 5));
      }
    }
    final snackBar = SnackBar(
      content: Text('Failed to load data after $maxAttempts attempts'),
      duration: Duration(seconds: 2), // Optional, default is 4 seconds
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    EasyLoading.dismiss();
    EasyLoading.showError("Failed!");
    throw Exception('Failed to load data after $maxAttempts attempts');
  }catch(e){
    final snackBar = SnackBar(
      content: Text('Failed to load data with error: $e'),
      duration: Duration(seconds: 2), // Optional, default is 4 seconds
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    EasyLoading.dismiss();
    EasyLoading.showError("Failed!");
    throw Exception('Failed to load data with error: $e');


  }


  }




  void initState() {
    super.initState();

    if(!MobileAppItems.HomeScreenShown) {
     fetchData();
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,

        children: [Image.asset(
          'assets/background.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
          Container(padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.22, 0, 0),
            child: Image.asset(
              'assets/appicon.png',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),],
      ),
    );
  }
}
