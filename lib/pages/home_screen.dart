import 'dart:convert';
import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';
import 'package:http/http.dart' as http;
import 'package:rijksmuseum/pages/detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: AppBar(
                title: Text('Rijks Museum Api Assignment'),
              ))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage('assets/appicon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application Assignment',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'This application is created for an assignment to utilize the Rijksmuseum API by ',
                        ),
                        TextSpan(
                          text: 'Volkan Usanmaz',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Add more items here
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/background.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ), // Add some spacing between the images
          Container(
            width: (MediaQuery.of(context).size.width > 700)
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: MobileAppItems.CollectionData.length,
              itemBuilder: (context, index) {
                var artObject = MobileAppItems.CollectionData[index];

                Future<ArtObjectResponse> fetchData() async {
                  try {
                    EasyLoading.instance
                      ..loadingStyle = EasyLoadingStyle.custom
                      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
                      ..indicatorColor = Colors.black
                      ..backgroundColor = Colors.grey
                      ..textColor = Colors.black;

                    EasyLoading.show(
                      status: "Loading",
                    );

                    int maxAttempts = 5;
                    int attempt = 0;

                    while (attempt < maxAttempts) {
                      final response = await http.get(Uri.parse(
                          artObject.selfLink +
                              '?key=' +
                              MobileAppItems.ApiKey));
                      if (response.statusCode == 200) {
                        EasyLoading.dismiss();
                        EasyLoading.showSuccess("Success!");

                        Map<String, dynamic> jsonData =
                            json.decode(response.body);
                        ArtObjectResponse artObject =
                            ArtObjectResponse.fromJson(jsonData);

                        MobileAppItems.DetailData = null;
                        MobileAppItems.DetailData = await artObject;
                        Future.delayed(Duration(seconds: 3), () {
                          MobileAppItems.HomeScreenShown = true;
                          Navigator.of(context).push(
                            CubePageRoute(
                              enterPage: DetailPage(),
                              exitPage: HomeScreen(),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        });
                        return artObject;
                      } else {
                        attempt++;
                        await Future.delayed(Duration(seconds: 5));
                      }
                    }
                    final snackBar = SnackBar(
                      content: Text(
                          'Failed to load data after $maxAttempts attempts'),
                      duration: Duration(seconds: 2),
                      // Optional, default is 4 seconds
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    EasyLoading.dismiss();
                    EasyLoading.showError("Failed!");
                    throw Exception(
                        'Failed to load data after $maxAttempts attempts');
                  } catch (e) {
                    final snackBar = SnackBar(
                      content: Text('Failed to load data with error: $e'),
                      duration: Duration(seconds: 2),
                      // Optional, default is 4 seconds
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    EasyLoading.dismiss();
                    EasyLoading.showError("Failed!");
                    throw Exception('Failed to load data with error: $e');
                  }
                }

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: !(MediaQuery.of(context).size.width > 700)
                              ? Stack(
                                  children: [
                                    Image.network(
                                      artObject.headerImage.url,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              (artObject.headerImage.height /
                                                  artObject.headerImage.width),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Positioned(
                                      bottom: 8.0,
                                      right: 8.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          fetchData();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors
                                                .blue, // Background color of the circular container
                                          ),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Center(
                                      child: Image.network(
                                        artObject.headerImage.url,
                                        height: MediaQuery.of(context)
                                                .size
                                                .width *
                                            (artObject.headerImage.height /
                                                artObject.headerImage.width) /
                                            3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        fit: BoxFit.fill,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16.0,
                                      right: 64.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          fetchData();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors
                                                .blue, // Background color of the circular container
                                          ),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(height: 8.0),
                        !artObject.showLongTitle
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    artObject.showLongTitle =
                                        !artObject.showLongTitle;
                                  });
                                },
                                child: Text(
                                  artObject.title + "...",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    artObject.showLongTitle =
                                        !artObject.showLongTitle;
                                  });
                                },
                                child: Text(
                                  artObject.longTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                        SizedBox(height: 4.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
