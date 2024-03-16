import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:rijksmuseum/controller/collectives_bloc.dart';
import 'package:rijksmuseum/controller/detail_bloc.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:rijksmuseum/pages/detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _pageNumber.text = MobileAppItems.pageNumber.toString();
    _itemsPerPage.text = MobileAppItems.numberOfItems.toString();
  }

  final TextEditingController  _pageNumber = TextEditingController();
  final TextEditingController _itemsPerPage = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MobileAppItems.appBackgroundcolor,
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
                backgroundColor: MobileAppItems.backgroundColor, // Use your preferred color
                title: _isSearching
                    ? TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                        onChanged: (query) {
                          MobileAppItems.searchText=query;
                          CollectivesBloc().fetchData();
                        },
                      )
                    : const Text('Rijks Museum Assignment',
                        style: TextStyle(fontSize: 18)),
                actions: [
                  !_isSearching?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSearching = !_isSearching;

                          });
                        },
                        child:const Icon(Icons.search),
                      ),
                    ):Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _searchController.text="";
            MobileAppItems.searchText="";
            _isSearching = !_isSearching;
            CollectivesBloc().fetchData();
          });
        },
        child:const Icon(Icons.search_off),
      ),
    ),
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Icon(Icons.grid_on),
                  ),
                ],
              ))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: MobileAppItems.backgroundColor,
                  image: DecorationImage(
                    image: AssetImage('assets/appicon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container()),
            Container(
              color: MobileAppItems.backgroundColor,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Application Assignment',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
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
            ),
            // Add more items here
          ],
        ),
      ),
      body: StreamBuilder<List<ArtObject>>(
        stream: CollectivesBloc().artObjectsStream,
        builder: (context, snapshot) {
          if (_isLoading ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width > 700)
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: CollectivesBloc.collectionData.length,
                      itemBuilder: (context, index) {
                        var artObject = CollectivesBloc.collectionData[index];

                        return Card(
                          color: MobileAppItems.backgroundColor,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: !(MediaQuery.of(context).size.width >
                                          700)
                                      ? Stack(
                                          children: [
                                            artObject.hasImage
                                                ? Image.network(
                                                    artObject.headerImage!.url,
                                                    height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        (artObject.headerImage!
                                                                .height /
                                                            artObject
                                                                .headerImage!
                                                                .width),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      } else {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
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
                                                  )
                                                : Image.asset(
                                                    "assets/nophoto.jpg",
                                                    height: 200),
                                            Positioned(
                                              bottom: 8.0,
                                              right: 8.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  navigateToNextPage(artObject);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors
                                                        .blue, // Background color of the circular container
                                                  ),
                                                  child: const Icon(
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
                                              child: artObject.hasImage
                                                  ? Image.network(
                                                      artObject
                                                          .headerImage!.url,
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width *
                                                          (artObject
                                                                  .headerImage!
                                                                  .height /
                                                              artObject
                                                                  .headerImage!
                                                                  .width),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.fill,
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
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
                                                    )
                                                  : Image.asset(
                                                      "assets/nophoto.jpg",
                                                      height: 200),
                                            ),
                                            Positioned(
                                              bottom: 16.0,
                                              right: 64.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  navigateToNextPage(artObject);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors
                                                        .blue, // Background color of the circular container
                                                  ),
                                                  child: const Icon(
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
                                const SizedBox(height: 8.0),
                                !artObject.showLongTitle
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            artObject.showLongTitle =
                                                !artObject.showLongTitle;
                                          });
                                        },
                                        child: Text(
                                          "${artObject.title}...",
                                          style: const TextStyle(
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
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 4.0),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PreferredSize(
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
                        child: BottomAppBar(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: TextField(
                                      controller: _pageNumber,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        labelText: 'Page Number',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // Handle page number change
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: TextField(
                                      controller: _itemsPerPage,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        labelText: 'Item Per Page',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // Handle items per page change
                                      },
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (int.parse(_itemsPerPage.text) *
                                              int.parse(_pageNumber.text) <
                                          10000) {
                                        MobileAppItems.numberOfItems =
                                            int.parse(_itemsPerPage.text);
                                        MobileAppItems.pageNumber =
                                            int.parse(_pageNumber.text);
                                        CollectivesBloc().fetchData();
                                        setState(() {});
                                      } else {
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              "(Items per page * Page Number) cant exceed 10000"),
                                          duration: const Duration(seconds: 5),
                                          action: SnackBarAction(
                                            label: 'Close',
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } catch (e) {
                                      final snackBar = SnackBar(
                                        content: Text(e.toString()),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
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
                      style: TextStyle(
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
                        setState(() {
                          _isLoading = true; // Update loading state
                        });

                        Future.delayed(const Duration(seconds: 3), () {
                          CollectivesBloc().fetchData().then((_) {
                            setState(() {
                              _isLoading =
                                  false; // Reset loading state after fetch
                            });
                          }).catchError((error) {
                            setState(() {
                              _isLoading =
                                  false; // Reset loading state on error
                            });
                          });
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width > 700)
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: CollectivesBloc.collectionData.length,
                      itemBuilder: (context, index) {
                        var artObject = CollectivesBloc.collectionData[index];

                        return Card(
                          color: MobileAppItems.backgroundColor,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: !(MediaQuery.of(context).size.width >
                                          700)
                                      ? Stack(
                                          children: [
                                            artObject.hasImage
                                                ? Image.network(
                                                    artObject.headerImage!.url,
                                                    height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        (artObject.headerImage!
                                                                .height /
                                                            artObject
                                                                .headerImage!
                                                                .width),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      } else {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
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
                                                  )
                                                : Image.asset(
                                                    "assets/nophoto.jpg",
                                                    height: 120,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.fill,
                                                  ),
                                            Positioned(
                                              bottom: 8.0,
                                              right: 8.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  navigateToNextPage(artObject);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors
                                                        .blue, // Background color of the circular container
                                                  ),
                                                  child: const Icon(
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
                                              child: artObject.hasImage
                                                  ? Image.network(
                                                      artObject
                                                          .headerImage!.url,
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width *
                                                          (artObject
                                                                  .headerImage!
                                                                  .height /
                                                              artObject
                                                                  .headerImage!
                                                                  .width),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.fill,
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
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
                                                    )
                                                  : Image.asset(
                                                      "assets/nophoto.jpg",
                                                      height: 200,
                                                    ),
                                            ),
                                            Positioned(
                                              bottom: 16.0,
                                              right: 64.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  navigateToNextPage(artObject);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors
                                                        .blue, // Background color of the circular container
                                                  ),
                                                  child: const Icon(
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
                                const SizedBox(height: 8.0),
                                !artObject.showLongTitle
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            artObject.showLongTitle =
                                                !artObject.showLongTitle;
                                          });
                                        },
                                        child: Text(
                                          "${artObject.title}...",
                                          style: const TextStyle(
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
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 4.0),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PreferredSize(
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
                        child: BottomAppBar(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: TextField(
                                      controller: _pageNumber,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        labelText: 'Page Number',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // Handle page number change
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: TextField(
                                      controller: _itemsPerPage,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        labelText: 'Item Per Page',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // Handle items per page change
                                      },
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (int.parse(_itemsPerPage.text) *
                                              int.parse(_pageNumber.text) <
                                          10000) {
                                        MobileAppItems.numberOfItems =
                                            int.parse(_itemsPerPage.text);
                                        MobileAppItems.pageNumber =
                                            int.parse(_pageNumber.text);
                                        CollectivesBloc().fetchData();
                                        setState(() {});
                                      } else {
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              "(Items per page * Page Number) cant exceed 10000"),
                                          duration: const Duration(seconds: 2),
                                          // Optional, default is 4 seconds
                                          action: SnackBarAction(
                                            label: 'Close',
                                            onPressed: () {},
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } catch (e) {
                                      final snackBar = SnackBar(
                                        content: Text(e.toString()),
                                        duration: const Duration(seconds: 2),
                                        // Optional, default is 4 seconds
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                )
              ],
            );
          }
        },
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  void navigateToNextPage(ArtObject artObject) {
    DetailBloc.detailLink =
        '${artObject.selfLink}?key=${MobileAppItems.apiKey}';
    DetailBloc.containsImage = artObject.hasImage;
    Navigator.of(context).push(
      CubePageRoute(
        enterPage: const DetailPage(),
        exitPage: const HomeScreen(),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
}
