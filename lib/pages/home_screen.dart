import 'package:flutter/material.dart';
import 'package:rijksmuseum/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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
            width:  (MediaQuery.of(context).size.width>700)?MediaQuery.of(context).size.width*0.5:MediaQuery.of(context).size.width,
            child: ListView.builder(

              itemCount: MyApp.CollectionData.length,
              itemBuilder: (context, index) {
                var artObject = MyApp.CollectionData[index];
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
                          child: !(MediaQuery.of(context).size.width>700)?Stack(
                            children: [
                              Image.network(
                                artObject.headerImage.url,
                                height: MediaQuery.of(context).size.width*(artObject.headerImage.height/artObject.headerImage.width),
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 8.0,
                                right: 8.0,
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue, // Background color of the circular container
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


                          ):Stack(
                            children: [
                              Center(
                                child: Image.network(
                                  artObject.headerImage.url,
                                  height: MediaQuery.of(context).size.width*(artObject.headerImage.height/artObject.headerImage.width)/3,
                                  width: MediaQuery.of(context).size.width/3,
                                  fit: BoxFit.fill,
                                ),
                              ),
                               Positioned(
                                  bottom: 16.0,
                                  right: 64.0,
                                  child: GestureDetector(
                                    onTap: () {

                                    },
                                    child:Container(


                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue, // Background color of the circular container
                                      ),
                                      child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),  ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        !artObject.showLongTitle?GestureDetector(
                          onTap: (){setState(() {
                            artObject.showLongTitle=!artObject.showLongTitle;
                          });},
                          child: Text(
                            artObject.title+"...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ): GestureDetector(
                          onTap: (){setState(() {
                            artObject.showLongTitle=!artObject.showLongTitle;
                          });},
                          child:Text(
                          artObject.longTitle,
                          style: TextStyle( fontWeight: FontWeight.bold,
                            fontSize: 16.0,),
                        ),),
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
