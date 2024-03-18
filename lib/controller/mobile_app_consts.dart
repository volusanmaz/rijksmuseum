import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';
import 'package:flutter/material.dart';
class MobileAppItems{
  static int pageNumber=5;
  static int numberOfItems=10;
  static String apiKey="";
  static String searchText="";
  static bool homeScreenShown=false;

  //language can be "nl" or "en"
  static String collectionSearch(String value){return "http://www.rijksmuseum.nl/api/en/collection?key=$apiKey&q=$value";}
  static String collectionApiAdress(String language){return "https://www.rijksmuseum.nl/api/$language/collection?key=$apiKey&culture=$language&p=$pageNumber&ps=$numberOfItems";}
  static const backgroundColor=Color(0xfff2f2f2);
  static const appBackgroundcolor=Color(0xff0a3345);

}
