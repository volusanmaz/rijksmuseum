import 'package:flutter/material.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(MobileAppItems.DetailData!.artObject.title),
              ))),
      body: Stack(
        children: [  Image.asset(
          'assets/background.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.network(
                          MobileAppItems.DetailData!.artObject.webImage.url,
                          height: (MediaQuery.of(context).size.width *
                                  (MobileAppItems.DetailData!.artObject.webImage.height /
                                      MobileAppItems.DetailData!.artObject.webImage.width)) /
                              1.2,
                          width: MediaQuery.of(context).size.width / 1.2,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        )),
                    ListTile(
                      title: Text(
                        MobileAppItems.DetailData!.artObject.longTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                      'Object Number : '+MobileAppItems.DetailData!.artObjectPage.objectNumber  +'\n'  +   MobileAppItems.DetailData!.artObjectPage.plaqueDescription,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),


                    ListTile(
                      title: Text('Principal or First Maker'),
                      subtitle: Text(MobileAppItems.DetailData!.artObject.principalOrFirstMaker),
                    ),

                    ListTile(
                      title: Text('Label'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title: ${MobileAppItems.DetailData!.artObject.label.title}'),
                          Text('Maker Line: ${MobileAppItems.DetailData!.artObject.label.makerLine}'),
                          Text('Description: ${MobileAppItems.DetailData!.artObject.label.description}'),
                          Text('Date: ${MobileAppItems.DetailData!.artObject.label.date}'),
                        ],
                      ),
                    ),ListTile(
                      title: Text('Dimensions'),
                      subtitle: Text(MobileAppItems.DetailData!.artObject.subTitle),
                    ),
                    ListTile(
                      title: Text('Location'),
                      subtitle: Text(MobileAppItems.DetailData!.artObject.location),
                    ), ListTile(
                      title: Text('Documentation'),
                      subtitle: Text( MobileAppItems.DetailData!.artObject.documentation.join('\n')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
