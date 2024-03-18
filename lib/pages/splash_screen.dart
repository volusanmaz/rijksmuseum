import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:rijksmuseum/pages/home_screen.dart';
import 'package:rijksmuseum/controller/collectives_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    CollectivesBloc().fetchData();
  }
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<ArtObject>>(
          stream: CollectivesBloc().artObjectsStream,
          builder: (context, snapshot) {
            if (_isLoading || snapshot.connectionState == ConnectionState.waiting) {
              return Stack(
                children: [Image.asset(
                  'assets/fakesplash.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
                  const Center(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          strokeWidth: 4,
                        ),
                         SizedBox(height: 20),
                         Text(
                          'Loading...',
                          style:  TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Stack(
                children: [Image.asset(
                  'assets/fakesplash.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.4,
                        decoration: BoxDecoration(color:Colors.white.withOpacity(0.8),borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Oops!',
                              style:  TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'An error occurred:',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              snapshot.error.toString(),
                              style: const TextStyle(fontSize: 16, color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {  setState(() {
                                _isLoading = true; // Update loading state
                              });
                        
                              Future.delayed(const Duration(seconds: 3), () {
                                CollectivesBloc().fetchData().then((_) {
                                  setState(() {
                                    _isLoading = false; // Reset loading state after fetch
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false; // Reset loading state on error
                                  });
                                });
                              });
                                CollectivesBloc().fetchData();
                        
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                ],
              );
            } else {
              // Navigate to home screen when data is loaded
              Future.delayed(const Duration(seconds: 1), () {

                if(!MobileAppItems.homeScreenShown){
                  Navigator.pop(context);
                Navigator.of(context).push(
                  CubePageRoute(
                    enterPage: const HomeScreen(),
                    exitPage: SplashScreen(),
                    duration: const Duration(milliseconds: 2000),
                  ),
                );MobileAppItems.homeScreenShown = true;}
              });
              return Image.asset(
                'assets/fakesplash.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              );
            }
          },
        ),
      ),
    );
  }


}