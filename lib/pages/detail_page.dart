import 'package:flutter/material.dart';
import 'package:rijksmuseum/controller/detail_bloc.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';

class DetailPage extends StatefulWidget {

  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isDisposed = false;
  final DetailBloc _detailBloc = DetailBloc();
  @override
  void initState() {
    _detailBloc.fetchData(DetailBloc.detailLink);
    super.initState();
  }
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ArtObjectResponse>(
        stream: _detailBloc.detailDataStream,
        builder: (context, snapshot) {
          if (_isLoading || snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(
                      decoration: const BoxDecoration(
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
                        backgroundColor: MobileAppItems.backgroundColor,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {_isDisposed=true;
                            Navigator.pop(context);
                          },
                        ),

                      ))),
              body: Stack(
                children: [Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/background.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.22, 0, 0),
                      child: Image.asset(
                        'assets/appicon.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
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
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(
                      decoration: const BoxDecoration(
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
                        backgroundColor: MobileAppItems.backgroundColor,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {_isDisposed=true;
                            Navigator.pop(context);
                          },
                        ),
                        title: Text(DetailBloc.detailData?.artObject.title??"No Title"),
                      ))),
              body: Stack(
                children: [Image.asset(
                  'assets/background.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
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
                            onPressed: () {
                              if (_isDisposed) return;
                              setState(() {
                                _isLoading = true; // Update loading state
                              });

                              Future.delayed(const Duration(seconds: 3), () {
                                if (_isDisposed) return;

                                _detailBloc.fetchData(DetailBloc.detailLink).then((_) {
                                  setState(() {
                                    _isLoading = false; // Reset loading state after fetch
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false; // Reset loading state on error
                                  });
                                });
                              });

                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),

                  ),
                ],
              ),
            );
          } else {

            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(
                      decoration: const BoxDecoration(
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
                        backgroundColor: MobileAppItems.backgroundColor,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            _isDisposed=true;
                            Navigator.pop(context);
                          },
                        ),
                        title: Text(DetailBloc.detailData?.artObject.title ?? "No title") ,
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
                      child: Card(color: MobileAppItems.backgroundColor,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: DetailBloc.containsImage?Image.network(
                                  DetailBloc.detailData!.artObject.webImage!.url,
                                  height: (MediaQuery.of(context).size.width *
                                      (DetailBloc.detailData!.artObject.webImage!.height /
                                          DetailBloc.detailData!.artObject.webImage!.width)) /
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
                                ):Container()),
                            ListTile(
                              title: Text(
                                DetailBloc.detailData?.artObject.longTitle ?? "No long title",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                'Object Number : ${DetailBloc.detailData?.artObject.objectNumber ??"Does not have one..."} \n${DetailBloc.detailData?.artObjectPage.plaqueDescription ?? ""}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),


                            ListTile(
                              title: const Text('Principal or First Maker'),
                              subtitle: Text(DetailBloc.detailData?.artObject.principalOrFirstMaker ??" Not Defined"),
                            ),

                            ListTile(
                              title: const Text('Label'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title: ${DetailBloc.detailData?.artObject.label.title ??"Not Defined"}'),
                                  Text('Maker Line: ${DetailBloc.detailData?.artObject.label.makerLine??"Not Defined"}'),
                                  Text('Description: ${DetailBloc.detailData?.artObject.label.description??"Not Defined"}'),
                                  Text('Date: ${DetailBloc.detailData?.artObject.label.date ??"Not Defined"}'),
                                ],
                              ),
                            ),ListTile(
                              title: const Text('Dimensions'),
                              subtitle: Text(DetailBloc.detailData?.artObject.subTitle??"Not Defined"),
                            ),
                            ListTile(
                              title: const Text('Location'),
                              subtitle: Text(DetailBloc.detailData?.artObject.location??"Not Defined"),
                            ), ListTile(
                              title: const Text('Documentation'),
                              subtitle:DetailBloc.detailData!.artObject.documentation.isEmpty? const Text("No Documantation"):Text( DetailBloc.detailData!.artObject.documentation.join('\n')),
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
        },
      ),
    );
  }

  @override
  void dispose() {

    _detailBloc.dispose();

    super.dispose();
  }
}
